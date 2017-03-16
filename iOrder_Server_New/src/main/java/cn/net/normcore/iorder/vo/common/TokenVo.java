package cn.net.normcore.iorder.vo.common;

import java.io.Serializable;

/**
 * TOKEN实体
 * Created by 81062 on 2017/3/16.
 */
public class TokenVo implements Serializable {
    private long id;  //用户ID
    private char type;  //用户类型，1-顾客，2-商家
    private String ip;  //客户端IP地址，同时验证TOKEN和IP地址，防止TOKEN被窃取盗用

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public char getType() {
        return type;
    }

    public void setType(char type) {
        this.type = type;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }
}
