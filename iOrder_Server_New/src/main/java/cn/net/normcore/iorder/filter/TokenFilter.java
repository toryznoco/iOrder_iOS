package cn.net.normcore.iorder.filter;

import cn.net.normcore.iorder.common.utils.ClientUtils;
import cn.net.normcore.iorder.common.utils.Config;
import cn.net.normcore.iorder.service.cache.AccessTokenCacheService;
import cn.net.normcore.iorder.vo.token.AccessToken;
import cn.net.normcore.iorder.vo.token.UserType;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.container.ContainerRequestFilter;
import javax.ws.rs.core.Context;
import java.io.IOException;

/**
 * TOKEN过滤器
 * Created by RenQiang on 2017/3/20.
 */
@ValidateToken
public class TokenFilter implements ContainerRequestFilter {
    @Context
    private HttpServletRequest request;
    @Context
    private HttpServletResponse response;
    @Autowired
    private AccessTokenCacheService accessTokenCacheService;

    @Override
    public void filter(ContainerRequestContext requestContext) throws IOException {
        String tokenValue = request.getParameter(Config.getProperty("access_token_key"));
        if (tokenValue == null) {
            tokenValue = requestContext.getHeaderString(Config.getProperty("access_token_key"));
        }
        //TOKEN格式错误
        if (tokenValue == null || tokenValue.length() != 32) {
            response.sendRedirect("/api/basic/token/error");
            return;
        }
        //查询缓存中的TOKEN数据
        AccessToken accessToken = accessTokenCacheService.get(tokenValue);
        //缓存中没有查询到TOKEN或者存入TOKEN的客户端ID与当前请求客户端ID不匹配（说明TOKEN被盗用）都视为TOKEN验证失败
        if (accessToken == null || !accessToken.getClientId().equals(ClientUtils.buildClientId(request))) {
            response.sendRedirect("/api/basic/token/invalid");
            return;
        }

        //把用户ID放入请求
        if (accessToken.getUserType().equals(UserType.CUSTOMER))
            requestContext.getHeaders().add("customerId", String.valueOf(accessToken.getUserId()));
        if (accessToken.getUserType().equals(UserType.SHOPMAN))
            requestContext.getHeaders().add("shopmanId", String.valueOf(accessToken.getUserId()));

        //把TOKEN有效时间放入响应头
        response.addHeader(Config.getProperty("token_ttl_key"), String.valueOf(accessTokenCacheService.getTTL(tokenValue)));
    }
}
