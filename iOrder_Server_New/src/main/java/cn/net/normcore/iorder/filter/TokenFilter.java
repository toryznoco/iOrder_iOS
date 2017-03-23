package cn.net.normcore.iorder.filter;

import cn.net.normcore.iorder.common.utils.ClientUtils;
import cn.net.normcore.iorder.common.utils.Config;
import cn.net.normcore.iorder.service.redis.TokenService;
import cn.net.normcore.iorder.vo.common.Client;
import cn.net.normcore.iorder.vo.common.Token;
import cn.net.normcore.iorder.vo.common.UserType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
    private static final Logger LOGGER = LoggerFactory.getLogger(TokenFilter.class);
    @Autowired
    private TokenService tokenService;
    @Context
    private HttpServletRequest request;
    @Context
    private HttpServletResponse response;

    @Override
    public void filter(ContainerRequestContext requestContext) throws IOException {
        String tokenValue = request.getParameter(Config.getProperty("token_key"));
        if (tokenValue == null) {
            tokenValue = requestContext.getHeaderString(Config.getProperty("token_key"));
        }
        //TOKEN格式错误
        if (tokenValue == null || tokenValue.length() != 32) {
            LOGGER.error("TOKEN格式错误，token=[{}]，URI=[{}]", tokenValue, requestContext.getUriInfo().getPath());
            response.sendRedirect("/api/basic/token/error");
            return;
        }
        //查询缓存中的TOKEN数据
        Token token = tokenService.get(tokenValue);
        //获得客户端唯一标识
        Client client = ClientUtils.buildClient(request);
        //缓存中没有查询到TOKEN或者存入TOKEN的客户端ID与当前请求客户端ID不匹配（说明TOKEN被盗用）都视为TOKEN验证失败
        if (token == null || !token.getClientId().equals(client.getClientId())) {
            LOGGER.error("TOKEN无效，token=[{}]，URI=[{}]，Client={}", tokenValue, requestContext.getUriInfo().getPath(), client);
            response.sendRedirect("/api/basic/token/invalid");
            return;
        }

        //把用户ID放入请求
        if (token.getUserType().equals(UserType.CUSTOMER))
            requestContext.getHeaders().add("customerId", String.valueOf(token.getUserId()));
        if (token.getUserType().equals(UserType.SHOPMAN))
            requestContext.getHeaders().add("shopmanId", String.valueOf(token.getUserId()));

        //把TOKEN有效时间放入响应头
        response.addHeader(Config.getProperty("token_ttl_key"), String.valueOf(tokenService.getTokenTTL(tokenValue)));
    }
}
