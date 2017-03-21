package cn.net.normcore.iorder.vo.common;

import cn.net.normcore.iorder.common.utils.InfoUtils;

/**
 * 客户端唯一标识
 * 以User-Agent + IP作为客户端唯一标识
 * 以用户类型 + 用户ID作为Redis Key
 */
public class Client {
    private UserType userType;  //用户类型
    private String ip;  //客户端IP地址
    private String userAgent;  //User-Agent请求头信息
    private long userId;  //用户实体ID

    @Override
    public String toString() {
        return String.format("{IP=%s, User-Agent=%s}", ip, userAgent);
    }

    /**
     * 获取客户端标识redis存取key
     *
     * @return
     */
    public String getRedisKey() {
        if (userType.equals(UserType.CUSTOMER)) {
            return "customer" + getUserId();
        }
        if (userType.equals(UserType.SHOPMAN)) {
            return "shopman" + getUserId();
        }
        return null;
    }

    /**
     * 获取客户端唯一标识字符串
     *
     * @return
     */
    public String getClientId() {
        return InfoUtils.parseStrToMd5L32(ip + userAgent);
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public UserType getUserType() {
        return userType;
    }

    public void setUserType(UserType userType) {
        this.userType = userType;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getUserAgent() {
        return userAgent;
    }

    public void setUserAgent(String userAgent) {
        this.userAgent = userAgent;
    }
}
