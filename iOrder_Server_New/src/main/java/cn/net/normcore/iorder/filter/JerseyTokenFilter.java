package cn.net.normcore.iorder.filter;

import cn.net.normcore.iorder.common.utils.ClientUtils;
import cn.net.normcore.iorder.common.utils.Config;
import cn.net.normcore.iorder.entity.customer.Customer;
import cn.net.normcore.iorder.service.redis.TokenService;
import cn.net.normcore.iorder.vo.common.Client;
import cn.net.normcore.iorder.vo.common.Token;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.container.ContainerRequestFilter;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;

/**
 * TOKEN过滤器
 * Created by RenQiang on 2017/3/20.
 */
@NeedToken
public class JerseyTokenFilter implements ContainerRequestFilter {
    private static final Logger LOGGER = LoggerFactory.getLogger(JerseyTokenFilter.class);
    @Autowired
    private TokenService tokenService;

    @Override
    public void filter(ContainerRequestContext requestContext) throws IOException {
        String tokenValue = (String) requestContext.getProperty(Config.getProperty("token_key"));
        if (tokenValue == null) {
            tokenValue = requestContext.getHeaderString(Config.getProperty("token_key"));
        }
        //TOKEN格式错误
        if (tokenValue == null || tokenValue.length() != 32) {
            LOGGER.error("TOKEN格式错误，token=[{}]，URI=[{}]", tokenValue, requestContext.getUriInfo().getPath());
            try {
                requestContext.setRequestUri(new URI("/open/common/token/error"));
            } catch (URISyntaxException e) {
                e.printStackTrace();
            }
            return;
        }
        //查询缓存中的TOKEN数据
        Token token = tokenService.get(tokenValue);
//        //获得客户端唯一标识
//        Client client = ClientUtils.buildClient(httpReq, new Customer());
//        //缓存中没有查询到TOKEN或者存入TOKEN的客户端ID与当前请求客户端ID不匹配（说明TOKEN被盗用）都视为TOKEN验证失败
//        if (token == null || !token.getClientId().equals(client.getClientId())) {
//            httpResp.sendRedirect("/open/common/token/invalid");
//            LOGGER.error("TOKEN无效，token=[{}]，URI=[{}]，Client={}", tokenValue, reqUri, client);
//            return;
//        }
//
//        //把用户ID放入请求
    }
}
