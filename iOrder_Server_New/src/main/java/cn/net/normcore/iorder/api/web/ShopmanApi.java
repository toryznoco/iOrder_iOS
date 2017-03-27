package cn.net.normcore.iorder.api.web;

import cn.net.normcore.iorder.common.SimpleResult;
import cn.net.normcore.iorder.common.utils.ClientUtils;
import cn.net.normcore.iorder.common.utils.UuidUtils;
import cn.net.normcore.iorder.entity.business.Shopman;
import cn.net.normcore.iorder.filter.ValidateToken;
import cn.net.normcore.iorder.service.business.ShopmanService;
import cn.net.normcore.iorder.service.cache.AccessTokenCacheService;
import cn.net.normcore.iorder.service.cache.ClientCacheService;
import cn.net.normcore.iorder.service.cache.RefreshTokenCacheService;
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

    @POST
    @Path("logout")
    @ValidateToken
    public Map<String, Object> logout(@HeaderParam("shopmanId") @NotNull Long shopmanId) {
        clientCacheService.delete(String.format("shopman[%d]", shopmanId));
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
        Shopman shopman = shopmanService.findLogin(shopmanVo.getAccount());
        if (shopman == null)
            return SimpleResult.pessimistic(4006, "账号不存在");
        if (!shopman.checkPassword(shopmanVo.getPassword()))
            return SimpleResult.pessimistic(4006, "密码错误");

        String clientKey = String.format("shopman[%d]", shopman.getId());
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
        refreshTokenCacheService.save(refreshToken, new RefreshToken(shopman.getId(), UserType.SHOPMAN, clientId, accessToken));
        accessTokenCacheService.save(accessToken, new AccessToken(shopman.getId(), UserType.SHOPMAN, clientId));
        clientCacheService.save(clientKey, new Client(clientId, refreshToken));

        Map<String, Object> result = SimpleResult.optimistic("登陆成功");
        result.put("refreshToken", refreshToken);
        result.put("accessToken", accessToken);
        return result;
    }
}
