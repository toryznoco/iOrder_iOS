package cn.net.normcore.iorder.vo.common;

import java.io.Serializable;

/**
 * TOKEN实体
 * Created by 81062 on 2017/3/16.
 */
public class Token implements Serializable {
    private long userId;  //用户ID
    private UserType userType;  //用户类型
    private String clientId;  //客户端唯一标识，同时验证TOKEN和客户端标识，防止TOKEN被窃取盗用

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

    public String getClientId() {
        return clientId;
    }

    public void setClientId(String clientId) {
        this.clientId = clientId;
    }
}
