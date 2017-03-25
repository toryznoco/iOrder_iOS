package cn.net.normcore.iorder.entity.customer;

import cn.net.normcore.iorder.common.utils.InfoUtils;
import cn.net.normcore.iorder.entity.BaseEntity;
import cn.net.normcore.iorder.entity.order.Order;

import javax.persistence.*;
import java.util.List;

/**
 * 消费者实体
 * Created by 81062 on 2017/3/15.
 */
@Entity
@Table(name = "customer")
public class Customer extends BaseEntity {
    private String mobile;  //手机号码
    private String nickName;  //昵称
    private String headImage;  //头像
    private String password;  //密码
    private String salt;  //密码MD5加盐
    private List<Order> orders;  //顾客的订单列表
    private List<MarkedShop> markedShops;  //收藏的店铺列表
    private List<MarkedGoods> markedGoods;  //收藏的商品列表

    @Column(name = "mobile", nullable = false, unique = true, length = 11)
    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    @Column(name = "nick_name", length = 50)
    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    @Column(name = "head_image", length = 100)
    public String getHeadImage() {
        return headImage;
    }

    public void setHeadImage(String headImage) {
        this.headImage = headImage;
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

    @OneToMany(mappedBy = "customer", fetch = FetchType.LAZY)
    public List<Order> getOrders() {
        return orders;
    }

    public void setOrders(List<Order> orders) {
        this.orders = orders;
    }

    @OneToMany(mappedBy = "customer", fetch = FetchType.LAZY)
    public List<MarkedShop> getMarkedShops() {
        return markedShops;
    }

    public void setMarkedShops(List<MarkedShop> markedShops) {
        this.markedShops = markedShops;
    }

    @OneToMany(mappedBy = "customer", fetch = FetchType.LAZY)
    public List<MarkedGoods> getMarkedGoods() {
        return markedGoods;
    }

    public void setMarkedGoods(List<MarkedGoods> markedGoods) {
        this.markedGoods = markedGoods;
    }

    /**
     * 判断密码是否正确
     *
     * @param password
     * @return
     */
    public boolean checkPassword(String password) {
        return InfoUtils.getMd5Password(password, getSalt()).equals(getPassword());
    }
}
