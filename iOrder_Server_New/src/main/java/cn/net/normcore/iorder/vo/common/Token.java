package cn.net.normcore.iorder.vo.common;

import java.io.Serializable;

/**
 * TOKEN实体
 * Created by 81062 on 2017/3/16.
 */
public class Token implements Serializable {
    private long id;  //用户ID
    private char type;  //用户类型，1-顾客，2-商家
    private String clientId;  //客户端唯一标识，同时验证TOKEN和客户端标识，防止TOKEN被窃取盗用

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

    public String getClientId() {
        return clientId;
    }

    public void setClientId(String clientId) {
        this.clientId = clientId;
    }
}
