package cn.net.normcore.iorder.vo.business;

import cn.net.normcore.iorder.entity.business.Shop;
import cn.net.normcore.iorder.entity.business.Shopman;
import cn.net.normcore.iorder.vo.BaseVo;

/**
 * Created by 81062 on 2017/3/21.
 */
public class ShopmanVo extends BaseVo {
    private String account;  //登陆账号，可以是餐厅名字或店主手机号码
    private String password;  //登陆时的密码
    private String loginName;  //登录名
    private String realName;  //真实姓名
    private String mobile;  //手机号码
    private String shopName;  //店主的商店

    public static ShopmanVo fromShopman(Shopman shopman) {
        ShopmanVo shopmanVo = new ShopmanVo();
        shopmanVo.setId(shopman.getId());
        shopmanVo.setLoginName(shopman.getLoginName());
        shopmanVo.setRealName(shopman.getRealName());
        shopmanVo.setMobile(shopman.getMobile());
        shopmanVo.setShopName(shopman.getShop().getName());
        return shopmanVo;
    }

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

    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getShopName() {
        return shopName;
    }

    public void setShopName(String shopName) {
        this.shopName = shopName;
    }
}
