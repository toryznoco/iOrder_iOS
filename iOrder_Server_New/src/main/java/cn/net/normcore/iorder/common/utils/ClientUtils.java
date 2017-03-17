package cn.net.normcore.iorder.common.utils;

import cn.net.normcore.iorder.entity.BaseEntity;
import cn.net.normcore.iorder.vo.common.Client;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

/**
 * 获取客户端信息的工具类
 * Created by 81062 on 2017/3/16.
 */
public class ClientUtils {
    private static final Logger LOGGER = LoggerFactory.getLogger(ClientUtils.class);

    /**
     * 获取客户端的唯一标识字符串
     *
     * @param request
     * @return
     */
    public static <E extends BaseEntity> Client<E> buildClient(HttpServletRequest request, E user) {
        Client<E> client = new Client<>();
        client.setUser(user);
        client.setIp(request.getRemoteHost());
        String userAgent = request.getHeader("User-Agent");
        if (StringUtils.isEmpty(userAgent)) {
            userAgent = String.valueOf(System.currentTimeMillis());
            LOGGER.warn("未提交User-Agent，IP=[{}]，User=[{}]，赋值默认User-Agent=[{}]", client.getIp(), client.getRedisKey(), userAgent);
        }
        client.setUserAgent(userAgent);
        return client;
    }

    /**
     * 获取请求主机IP地址,如果通过代理进来，则透过防火墙获取真实IP地址
     *
     * @param request
     * @return
     * @throws IOException
     */
    public final static String getClientIp(HttpServletRequest request) throws IOException {
        // 获取请求主机IP地址,如果通过代理进来，则透过防火墙获取真实IP地址
        String ip = request.getHeader("X-Forwarded-For");
        if (LOGGER.isInfoEnabled()) {
            LOGGER.info("getIpAddress(HttpServletRequest) - X-Forwarded-For - String ip=" + ip);
        }

        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
                ip = request.getHeader("Proxy-Client-IP");
                if (LOGGER.isInfoEnabled()) {
                    LOGGER.info("getIpAddress(HttpServletRequest) - Proxy-Client-IP - String ip=" + ip);
                }
            }
            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
                ip = request.getHeader("WL-Proxy-Client-IP");
                if (LOGGER.isInfoEnabled()) {
                    LOGGER.info("getIpAddress(HttpServletRequest) - WL-Proxy-Client-IP - String ip=" + ip);
                }
            }
            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
                ip = request.getHeader("HTTP_CLIENT_IP");
                if (LOGGER.isInfoEnabled()) {
                    LOGGER.info("getIpAddress(HttpServletRequest) - HTTP_CLIENT_IP - String ip=" + ip);
                }
            }
            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
                ip = request.getHeader("HTTP_X_FORWARDED_FOR");
                if (LOGGER.isInfoEnabled()) {
                    LOGGER.info("getIpAddress(HttpServletRequest) - HTTP_X_FORWARDED_FOR - String ip=" + ip);
                }
            }
            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
                ip = request.getRemoteAddr();
                if (LOGGER.isInfoEnabled()) {
                    LOGGER.info("getIpAddress(HttpServletRequest) - getRemoteAddr - String ip=" + ip);
                }
            }
        } else if (ip.length() > 15) {
            String[] ips = ip.split(",");
            for (int index = 0; index < ips.length; index++) {
                String strIp = ips[index];
                if (!("unknown".equalsIgnoreCase(strIp))) {
                    ip = strIp;
                    break;
                }
            }
        }
        LOGGER.info(ip);
        return ip;
    }
}
