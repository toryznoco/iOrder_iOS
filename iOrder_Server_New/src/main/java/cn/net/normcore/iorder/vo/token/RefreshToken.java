package cn.net.normcore.iorder.vo.token;

import java.io.Serializable;

/**
 * Created by 81062 on 2017/3/23.
 */
public class RefreshToken implements Serializable {
    private long userId;  //用户ID
    private UserType userType;  //用户类型
    private String accessToken;

    public RefreshToken(long userId, UserType userType, String accessToken) {
        this.userId = userId;
        this.userType = userType;
        this.accessToken = accessToken;
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

    public String getAccessToken() {
        return accessToken;
    }

    public void setAccessToken(String accessToken) {
        this.accessToken = accessToken;
    }
}
