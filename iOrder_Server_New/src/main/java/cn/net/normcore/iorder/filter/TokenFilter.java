package cn.net.normcore.iorder.filter;

import cn.net.normcore.iorder.common.utils.ClientUtils;
import cn.net.normcore.iorder.common.utils.Config;
import cn.net.normcore.iorder.entity.customer.Customer;
import cn.net.normcore.iorder.service.redis.TokenService;
import cn.net.normcore.iorder.vo.common.Client;
import cn.net.normcore.iorder.vo.common.Token;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.util.StringUtils;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.regex.Pattern;

/**
 * Token过滤器，所有请求都会首先经过TokenFilter
 * Created by RenQiang on 2017/3/16.
 */
public class TokenFilter implements Filter {
    private static final Logger LOGGER = LoggerFactory.getLogger(TokenFilter.class);
    private List<String> urlsToIntercept;
    private TokenService<Customer> tokenService;

    public void destroy() {
    }

    /**
     * 判断URL是否被拦截，即是否需要验证TOKEN
     *
     * @param url
     * @return
     */
    private boolean isUrlIntercepted(String url) {
        if (url.contains("."))
            return false;
        for (String urlRegex :
                urlsToIntercept) {
            if (Pattern.compile("^" + urlRegex).matcher(url).find())
                return true;
        }
        return false;
    }

    /**
     * TOKEN验证失败原因
     * 1、缓存中没有查询到TOKEN：没有获得过TOKEN或者TOKEN已经过期
     * 2、缓存中查询到TOKEN但是IP地址不符合：说明TOKEN被盗用，但是如果手动切换过手机网络可能也会出现这种情况，所以如果用户切换过手机网络也需要重新获取TOKEN
     *
     * @param req
     * @param resp
     * @param chain
     * @throws ServletException
     * @throws IOException
     */
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        HttpServletRequest httpReq = (HttpServletRequest) req;
        HttpServletResponse httpResp = (HttpServletResponse) resp;
        String reqUri = httpReq.getRequestURI();
        //如果URL不被拦截，直接放行
        if (!isUrlIntercepted(reqUri)) {
            chain.doFilter(req, resp);
            return;
        }
        //获得提交的TOKEN
        String tokenValue = req.getParameter(Config.getProperty("token_key"));
        if (tokenValue == null) {
            tokenValue = httpReq.getHeader(Config.getProperty("token_key"));
        }
        //TOKEN格式错误
        if (tokenValue == null || tokenValue.length() != 32) {
            httpResp.sendRedirect("/open/common/token/error");
            LOGGER.error("TOKEN格式错误，token=[{}]，URI=[{}]", tokenValue, reqUri);
            return;
        }
        //查询缓存中的TOKEN数据
        Token token = tokenService.get(tokenValue);
        //获得客户端唯一标识
        Client client = ClientUtils.buildClient(httpReq, new Customer());
        //缓存中没有查询到TOKEN或者存入TOKEN的客户端ID与当前请求客户端ID不匹配（说明TOKEN被盗用）都视为TOKEN验证失败
        if (token == null || !token.getClientId().equals(client.getClientId())) {
            httpResp.sendRedirect("/open/common/token/invalid");
            LOGGER.error("TOKEN无效，token=[{}]，URI=[{}]，Client={}", tokenValue, reqUri, client);
            return;
        }

        //把用户ID放入请求
        String queryString = httpReq.getQueryString();
        queryString += "&" + (token.getType() == '1' ? "customerId" : token.getType() == '2' ? "shopmanId" : "id") + "=" + token.getId();
        req.getRequestDispatcher(reqUri + "?" + queryString).forward(req, resp);
    }

    public void init(FilterConfig config) throws ServletException {
        //注入tokenService
        ApplicationContext appContext = WebApplicationContextUtils.getWebApplicationContext(config.getServletContext());
        tokenService = (TokenService<Customer>) appContext.getBean("tokenService");

        //获得web.xml中的filter配置参数
        String urlParams = config.getInitParameter("UrlToIntercept");
        if (!StringUtils.isEmpty(urlParams)) {
            urlsToIntercept = Arrays.asList(urlParams.split(","));
        }
        LOGGER.info("TOKEN拦截器初始化成功，拦截地址：{}", urlsToIntercept);
    }

}
