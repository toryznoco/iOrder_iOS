package cn.net.normcore.iorder.vo.common;

import cn.net.normcore.iorder.common.utils.InfoUtils;
import cn.net.normcore.iorder.entity.BaseEntity;
import cn.net.normcore.iorder.entity.business.Shopman;
import cn.net.normcore.iorder.entity.customer.Customer;

/**
 * 客户端唯一标识
 * 以User-Agent + IP作为客户端唯一标识
 *
 * @param <E> 用户类型
 */
public class Client<E extends BaseEntity> {
    private E user;  //用户对象
    private String ip;  //客户端IP地址
    private String userAgent;  //User-Agent请求头信息

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
        if (user instanceof Customer) {
            return "customer" + user.getId();
        }
        if (user instanceof Shopman) {
            return "shopman" + user.getId();
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

    public E getUser() {
        return user;
    }

    public void setUser(E user) {
        this.user = user;
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
