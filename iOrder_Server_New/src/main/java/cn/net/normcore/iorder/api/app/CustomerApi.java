package cn.net.normcore.iorder.api.app;

import cn.net.normcore.iorder.common.SimpleResult;
import cn.net.normcore.iorder.common.utils.ClientUtils;
import cn.net.normcore.iorder.common.utils.Config;
import cn.net.normcore.iorder.common.utils.InfoUtils;
import cn.net.normcore.iorder.common.utils.UuidUtils;
import cn.net.normcore.iorder.entity.customer.Customer;
import cn.net.normcore.iorder.filter.ValidateToken;
import cn.net.normcore.iorder.service.cache.*;
import cn.net.normcore.iorder.service.customer.CustomerService;
import cn.net.normcore.iorder.service.customer.SignInRecordService;
import cn.net.normcore.iorder.vo.token.UserType;
import cn.net.normcore.iorder.vo.customer.SignInRecordVo;
import cn.net.normcore.iorder.vo.token.AccessToken;
import cn.net.normcore.iorder.vo.token.Client;
import cn.net.normcore.iorder.vo.token.RefreshToken;
import com.fasterxml.jackson.databind.JsonNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import java.util.Calendar;
import java.util.Map;

/**
 * 顾客相关接口
 * Created by 81062 on 2017/3/16.
 */
@Controller
@Path("/app/customer")
@Produces(MediaType.APPLICATION_JSON)
public class CustomerApi {
    @Autowired
    private CustomerService customerService;
    @Autowired
    private SignInRecordService signInRecordService;
    @Autowired
    private ClientCacheService clientCacheService;
    @Autowired
    private RefreshTokenCacheService refreshTokenCacheService;
    @Autowired
    private AccessTokenCacheService accessTokenCacheService;

    /**
     * 顾客账号注册
     *
     * @param customer
     * @return
     */
    @POST
    @Path("/register")
    @Consumes(MediaType.APPLICATION_JSON)
    public Map<String, Object> register(Customer customer) {
        if (customer == null)
            return SimpleResult.pessimistic(4004, "请提交数据");
        if (!InfoUtils.isMobileNo(customer.getMobile()))
            return SimpleResult.pessimistic(4003, "手机号码格式错误");
        if (StringUtils.isEmpty(customer.getPassword()))
            return SimpleResult.pessimistic(4004, "参数[password]不能为空");
        if (customerService.findByMobile(customer.getMobile()) != null)
            return SimpleResult.pessimistic(4005, "手机号码已经注册");
        customer.setHeadImage("iorder/promotion/carousel2.png");
        customer.setSalt(InfoUtils.getMd5Salt());
        customer.setPassword(InfoUtils.getMd5Password(customer.getPassword(), customer.getSalt()));
        customerService.save(customer);
        return SimpleResult.optimistic("注册成功");
    }

    /**
     * 用户登陆
     *
     * @param data
     * @param request
     * @return
     */
    @POST
    @Path("/login")
    public Map<String, Object> login(JsonNode data, @Context HttpServletRequest request) {
        JsonNode account = data.get("account");
        JsonNode password = data.get("password");
        if (account == null)
            return SimpleResult.pessimistic(4004, "参数[account]不能为空");
        if (password == null)
            return SimpleResult.pessimistic(4004, "参数[password]不能为空");

        Customer customer = customerService.findByMobile(account.asText());
        if (customer == null)
            return SimpleResult.pessimistic(4006, "账号不存在");
        if (!customer.checkPassword(password.asText()))
            return SimpleResult.pessimistic(4006, "密码错误");

        String clientKey = String.format("customer[%d]", customer.getId());
        String clientId = ClientUtils.buildClientId(request);
        Client savedClient = clientCacheService.get(clientKey);
        if (savedClient != null && savedClient.getClientId().equals(clientId)) {
            return SimpleResult.pessimistic(4011, "你已经登陆");
        }
        if (savedClient != null) {
            refreshTokenCacheService.delete(savedClient.getRefreshToken());
        }

        String refreshToken = UuidUtils.simpleUuid();
        String accessToken = UuidUtils.simpleUuid();
        refreshTokenCacheService.save(refreshToken, new RefreshToken(customer.getId(), UserType.CUSTOMER, clientId, accessToken));
        accessTokenCacheService.save(accessToken, new AccessToken(customer.getId(), UserType.CUSTOMER, clientId));
        clientCacheService.save(clientKey, new Client(clientId, refreshToken));

        Map<String, Object> result = SimpleResult.optimistic("登陆成功");
        result.put("refreshToken", refreshToken);
        result.put("accessToken", accessToken);
        return result;
    }

    /**
     * 获取Access Token
     *
     * @param data
     * @param request
     * @return
     */
    @POST
    @Path("/token")
    public Map<String, Object> token(JsonNode data, @Context HttpServletRequest request) {
        String refreshTokenKey = data.get("refreshToken").asText();
        RefreshToken refreshToken = refreshTokenCacheService.get(refreshTokenKey);
        if (refreshToken == null || !ClientUtils.buildClientId(request).equals(refreshToken.getClientId())) {
            return SimpleResult.pessimistic(4002, "TOKEN无效");
        }
        AccessToken accessToken = accessTokenCacheService.get(refreshToken.getAccessToken());
        if (accessToken != null && accessTokenCacheService.getTTL(refreshToken.getAccessToken()) > (Config.getLong("access_token_ttl") - Config.getLong("access_token_interval"))) {
            return SimpleResult.pessimistic(4007, "获取token过于频繁");
        }
        refreshTokenCacheService.delete(refreshTokenKey);
        if (accessToken == null)
            accessToken = new AccessToken(refreshToken.getUserId(), refreshToken.getUserType(), refreshToken.getClientId());
        String accessTokenKey = UuidUtils.simpleUuid();
        accessTokenCacheService.save(accessTokenKey, accessToken);
        refreshTokenKey = UuidUtils.simpleUuid();
        refreshToken.setAccessToken(accessTokenKey);
        refreshTokenCacheService.save(refreshTokenKey, refreshToken);
        String clientKey = String.format("customer[%d]", refreshToken.getUserId());
        clientCacheService.save(clientKey, new Client(refreshToken.getClientId(), refreshTokenKey));

        Map<String, Object> result = SimpleResult.optimistic("刷新TOKEN成功");
        result.put("refreshToken", refreshTokenKey);
        result.put("accessToken", accessTokenKey);
        return result;
    }

    /**
     * 顾客用户收藏店铺
     *
     * @param shopId     店铺ID
     * @param remarks    备注
     * @param customerId 顾客用户ID，由TokenFilter放入请求
     * @return
     */
    @POST
    @Path("/mark/shop")
    @ValidateToken
    public Map<String, Object> markShop(@FormParam("shopId") Long shopId, @FormParam("remarks") String remarks, @HeaderParam("customerId") Long customerId) {
        if (shopId == null)
            return SimpleResult.pessimistic(4004, "参数[shopId]不能为空");
        if (customerId == null)
            return SimpleResult.pessimistic(5000, "系统内部错误，请联系开发者");
        customerService.markShop(customerId, shopId, remarks);
        return SimpleResult.optimistic();
    }

    /**
     * 顾客用户收藏商品
     *
     * @param goodsId    商品ID
     * @param remarks    备注
     * @param customerId 顾客ID，由TokenFilter放入请求
     * @return
     */
    @POST
    @Path("/mark/goods")
    @ValidateToken
    public Map<String, Object> markGoods(@FormParam("goodsId") Long goodsId, @FormParam("remarks") String remarks, @HeaderParam("customerId") Long customerId) {
        if (goodsId == null)
            return SimpleResult.pessimistic(4004, "参数[goodsId]不能为空");
        if (customerId == null)
            return SimpleResult.pessimistic(5000, "系统内部错误，请联系开发者");
        customerService.markGoods(customerId, goodsId, remarks);
        return SimpleResult.optimistic();
    }

    /**
     * 顾客用户店铺签到
     *
     * @param shopId
     * @param customerId
     * @return
     */
    @POST
    @Path("/signIn")
    @ValidateToken
    public Map<String, Object> signIn(@FormParam("shopId") Long shopId, @HeaderParam("customerId") Long customerId) {
        if (shopId == null)
            return SimpleResult.pessimistic(4004, "参数[shopId]不能为空");
        if (customerId == null)
            return SimpleResult.pessimistic(5000, "系统内部错误，请联系开发者");
        if (customerService.signIn(customerId, shopId))
            return SimpleResult.optimistic();
        return SimpleResult.pessimistic(4008, "不能重复签到");
    }

    /**
     * 查询顾客某店铺某月签到记录
     *
     * @param shopId     店铺ID
     * @param customerId 顾客ID
     * @param year       年份，自然年，2017表示2017年，默认值当前年份
     * @param month      月份，自然月，1表示1月，默认值当前月份
     * @return
     */
    @GET
    @Path("/signInRecords")
    @ValidateToken
    public Map<String, Object> signInRecords(@QueryParam("shopId") Long shopId, @HeaderParam("customerId") Long customerId, @QueryParam("year") Integer year, @QueryParam("month") Integer month) {
        if (shopId == null)
            return SimpleResult.pessimistic(4004, "参数[shopId]不能为空");
        if (customerId == null)
            return SimpleResult.pessimistic(5000, "系统内部错误，请联系开发者");
        if (year == null)
            year = Calendar.getInstance().get(Calendar.YEAR);
        if (month == null)
            month = Calendar.getInstance().get(Calendar.MONTH) + 1;
        Map<String, Object> result = SimpleResult.optimistic();
        result.put("signInRecords", SignInRecordVo.listFromSignInRecords(signInRecordService.findRecords(customerId, shopId, year, month)));
        return result;
    }
}
