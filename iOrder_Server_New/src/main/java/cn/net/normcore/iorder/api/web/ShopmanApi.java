package cn.net.normcore.iorder.api.web;

import cn.net.normcore.iorder.common.SimpleResult;
import cn.net.normcore.iorder.common.utils.ClientUtils;
import cn.net.normcore.iorder.common.utils.Config;
import cn.net.normcore.iorder.common.utils.UuidUtils;
import cn.net.normcore.iorder.entity.business.Shopman;
import cn.net.normcore.iorder.entity.customer.Customer;
import cn.net.normcore.iorder.filter.ValidateToken;
import cn.net.normcore.iorder.service.business.ShopmanService;
import cn.net.normcore.iorder.service.cache.AccessTokenCacheService;
import cn.net.normcore.iorder.service.cache.ClientCacheService;
import cn.net.normcore.iorder.service.cache.RefreshTokenCacheService;
import cn.net.normcore.iorder.service.cache.SimpleCacheService;
import cn.net.normcore.iorder.vo.business.ShopmanVo;
import cn.net.normcore.iorder.vo.token.AccessToken;
import cn.net.normcore.iorder.vo.token.Client;
import cn.net.normcore.iorder.vo.token.RefreshToken;
import cn.net.normcore.iorder.vo.token.UserType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import javax.servlet.http.HttpServletRequest;
import javax.validation.constraints.NotNull;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import java.util.Map;

/**
 * Created by 81062 on 2017/3/21.
 */
@Controller
@Path("/web/shopman")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class ShopmanApi {
    @Autowired
    private ShopmanService shopmanService;
    @Autowired
    private ClientCacheService clientCacheService;
    @Autowired
    private RefreshTokenCacheService refreshTokenCacheService;
    @Autowired
    private AccessTokenCacheService accessTokenCacheService;
    @Autowired
    private SimpleCacheService simpleCacheService;

    @POST
    @Path("logout")
    @ValidateToken
    public Map<String, Object> logout(@HeaderParam("shopmanId") @NotNull Long shopmanId) {
        String savedClient = simpleCacheService.get(String.format("shopman[%d]", shopmanId));
        simpleCacheService.delete(savedClient);
        simpleCacheService.delete(String.format("shopman[%d]", shopmanId));
        return SimpleResult.optimistic();
    }

    @GET
    @Path("/info")
    @ValidateToken
    public Map<String, Object> info(@HeaderParam("shopmanId") @NotNull Long shopmanId) {
        Map<String, Object> result = SimpleResult.optimistic();
        result.put("shopman", ShopmanVo.fromShopman(shopmanService.get(shopmanId)));
        return result;
    }

    /**
     * web端获取TOKEN
     *
     * @param request
     * @return
     */
    @POST
    @Path("/login")
    public Map<String, Object> token(ShopmanVo shopmanVo, @Context HttpServletRequest request) {
        String clientId = ClientUtils.buildClientId(request);
        if (simpleCacheService.get(clientId) != null)
            return SimpleResult.pessimistic(4011, "调用接口过于频繁");

        Shopman shopman = shopmanService.findLogin(shopmanVo.getAccount());
        if (shopman == null)
            return SimpleResult.pessimistic(4006, "账号不存在");
        if (!shopman.checkPassword(shopmanVo.getPassword()))
            return SimpleResult.pessimistic(4006, "密码错误");

        String clientKey = String.format("shopman[%d]", shopman.getId());
        String savedClient = simpleCacheService.get(clientKey);
        if (savedClient != null) {
            simpleCacheService.delete(savedClient);
        }

        String accessToken = UuidUtils.simpleUuid();
        simpleCacheService.save(clientKey, accessToken);
        accessTokenCacheService.save(accessToken, new AccessToken(shopman.getId(), UserType.SHOPMAN, clientId));
        simpleCacheService.save(clientId, clientId, Config.getLong("open_api_time_limit"));

        Map<String, Object> result = SimpleResult.optimistic("登陆成功");
        result.put("token", accessToken);
        return result;
    }
}
