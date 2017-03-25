package cn.net.normcore.iorder.vo.business;

import cn.net.normcore.iorder.vo.BaseVo;

/**
 * Created by 81062 on 2017/3/21.
 */
public class ShopmanVo extends BaseVo {
    private String account;  //登陆账号，可以是餐厅名字或店主手机号码
    private String password;  //登陆时的密码

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
