package cn.net.normcore.iorder.vo.token;

import java.io.Serializable;

/**
 * Created by 81062 on 2017/3/23.
 */
public class Client implements Serializable {
    private String clientId;  //客户端唯一标识
    private String refreshToken;

    public Client(String clientId, String refreshToken) {
        this.clientId = clientId;
        this.refreshToken = refreshToken;
    }

    public String getClientId() {
        return clientId;
    }

    public void setClientId(String clientId) {
        this.clientId = clientId;
    }

    public String getRefreshToken() {
        return refreshToken;
    }

    public void setRefreshToken(String refreshToken) {
        this.refreshToken = refreshToken;
    }
}
