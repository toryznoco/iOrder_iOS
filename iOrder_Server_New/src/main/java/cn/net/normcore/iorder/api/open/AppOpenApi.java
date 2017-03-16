package cn.net.normcore.iorder.api.open;

import cn.net.normcore.iorder.common.SimpleResult;
import cn.net.normcore.iorder.common.utils.ClientUtil;
import cn.net.normcore.iorder.common.utils.InfoUtil;
import cn.net.normcore.iorder.common.utils.UuidUtil;
import cn.net.normcore.iorder.entity.customer.Customer;
import cn.net.normcore.iorder.redis.ClientTokenRefreshRecordService;
import cn.net.normcore.iorder.redis.TokenService;
import cn.net.normcore.iorder.service.customer.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import java.io.IOException;
import java.util.Map;

/**
 * Created by 81062 on 2017/3/16.
 */
@Controller
@Path("/open/app")
@Produces(MediaType.APPLICATION_JSON)
public class AppOpenApi {
    @Autowired
    private CustomerService customerService;
    @Autowired
    private TokenService<Customer> tokenService;
    @Autowired
    private ClientTokenRefreshRecordService tokenRecordService;

    @POST
    @Path("/register")
    @Consumes(MediaType.APPLICATION_JSON)
    public Map<String, Object> register(Customer customer) {
        if (customer == null)
            return SimpleResult.pessimistic("4004", "请提交数据");
        if (!InfoUtil.isMobileNo(customer.getMobile()))
            return SimpleResult.pessimistic("4003", "手机号码格式错误");
        if (StringUtils.isEmpty(customer.getNickName()))
            return SimpleResult.pessimistic("4004", "参数[nickName]不能为空");
        if (StringUtils.isEmpty(customer.getPassword()))
            return SimpleResult.pessimistic("4004", "参数[password]不能为空");
        if (customerService.findByMobile(customer.getMobile()) != null)
            return SimpleResult.pessimistic("4005", "手机号码已经注册");
        customer.setHeadImage("iorder/promotion/carousel2.png");
        customer.setSalt(InfoUtil.getMd5Salt());
        customer.setPassword(InfoUtil.getMd5Password(customer.getPassword(), customer.getSalt()));
        customerService.save(customer);
        return SimpleResult.optimistic("注册成功");
    }

    @POST
    @Path("/token")
    public Map<String, Object> token(@FormParam("account") String account, @FormParam("password") String password, @Context HttpServletRequest request) {
        Customer customer = customerService.findByMobile(account);
        if (customer == null)
            return SimpleResult.pessimistic("4006", "账号不存在");
        if (!customer.checkPassword(password))
            return SimpleResult.pessimistic("4006", "密码错误");

        String ip = request.getRemoteHost();
        if ("1".equals(tokenRecordService.get(ip))) {
            return SimpleResult.pessimistic("4007", "获取TOKEN过于频繁");
        }

        String token = UuidUtil.simpleUuid();
        tokenService.save(token, ip, customer);
        tokenRecordService.save(ip);
        Map<String, Object> result = SimpleResult.optimistic("刷新TOKEN成功");
        result.put("token", token);
        return result;
    }
}
