package cn.net.normcore.iorder.common.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletRequest;

/**
 * 获取客户端信息的工具类
 * Created by 81062 on 2017/3/16.
 */
public class ClientUtils {
    private static final Logger LOGGER = LoggerFactory.getLogger(ClientUtils.class);

    public static String buildClientId(HttpServletRequest request) {
        String ip = request.getRemoteHost();
        String userAgent = request.getHeader("User-Agent");
        if (StringUtils.isEmpty(userAgent)) {
            userAgent = String.valueOf(System.currentTimeMillis());
            LOGGER.warn("未提交User-Agent，IP=[{}]，User=[{}]，赋值默认User-Agent=[{}]", ip, userAgent);
        }
        return InfoUtils.parseStrToMd5L32(ip + userAgent);
    }
}
