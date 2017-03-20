package cn.net.normcore.iorder.entity.business;

import cn.net.normcore.iorder.common.utils.InfoUtils;
import cn.net.normcore.iorder.entity.BaseEntity;

import javax.persistence.*;

/**
 * 商家（店主）实体
 * Created by 81062 on 2017/3/16.
 */
@Entity
@Table(name = "shopman")
public class Shopman extends BaseEntity {
    private String loginName;  //登录名
    private String realName;  //真实姓名
    private String password;  //密码
    private String salt;  //密码MD5加盐
    private String mobile;  //手机号码
    private Shop shop;  //店主的商店

    /**
     * 判断登录时密码是否匹配
     *
     * @param password
     * @return
     */
    public boolean checkPassword(String password) {
        return this.getPassword().equals(InfoUtils.getMd5Password(password, this.getSalt()));
    }

    @Column(name = "login_name", nullable = false, length = 50, unique = true)
    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

    @Column(name = "real_name", length = 20, nullable = false)
    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    @Column(name = "password", length = 32, nullable = false)
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Column(name = "salt", length = 8, nullable = false)
    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }

    @Column(name = "mobile", length = 11, nullable = false, unique = true)
    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    @OneToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "shop_id")
    public Shop getShop() {
        return shop;
    }

    public void setShop(Shop shop) {
        this.shop = shop;
    }
}
