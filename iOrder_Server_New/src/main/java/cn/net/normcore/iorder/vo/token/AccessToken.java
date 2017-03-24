package cn.net.normcore.iorder.vo.token;

import java.io.Serializable;

/**
 * Created by 81062 on 2017/3/23.
 */
public class AccessToken implements Serializable {
    private long userId;  //用户ID
    private UserType userType;  //用户类型
    private String clientId;  //客户端唯一标识，同时验证TOKEN和客户端标识，防止TOKEN被窃取盗用

    public AccessToken(long userId, UserType userType, String clientId) {
        this.userId = userId;
        this.userType = userType;
        this.clientId = clientId;
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

    public String getClientId() {
        return clientId;
    }

    public void setClientId(String clientId) {
        this.clientId = clientId;
    }
}
