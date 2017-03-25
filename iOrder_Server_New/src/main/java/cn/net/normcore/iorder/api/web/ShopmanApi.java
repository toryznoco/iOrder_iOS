package cn.net.normcore.iorder.api.web;

import cn.net.normcore.iorder.service.business.ShopmanService;
import cn.net.normcore.iorder.vo.business.ShopmanVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import javax.servlet.http.HttpServletRequest;
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

    /**
     * web端获取TOKEN
     *
     * @param request
     * @return
     */
    @POST
    @Path("/token")
    public Map<String, Object> token(ShopmanVo shopmanVo, @Context HttpServletRequest request) {
//        Shopman shopman = shopmanService.findLogin(shopmanVo.getAccount());
//        if (shopman == null)
//            return SimpleResult.pessimistic(4006, "账号不存在");
//        if (!shopman.checkPassword(shopmanVo.getPassword()))
//            return SimpleResult.pessimistic(4006, "密码错误");
//
//        Client client = ClientUtils.buildClient(request, shopman);
//        if (client.getClientId().equals(clientService.getClientId(client)))
//            return SimpleResult.pessimistic(4007, "获取TOKEN过于频繁");
//
//        String token = UuidUtils.simpleUuid();
//        //tokenCacheService.save(token, client.getClientId(), shopman);
//        clientService.saveClientId(client);
//        Map<String, Object> result = SimpleResult.optimistic("刷新TOKEN成功");
//        result.put("token", token);
//        return result;
        return null;
    }
}
