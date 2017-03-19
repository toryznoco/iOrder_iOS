package cn.net.normcore.iorder.entity.customer;

import cn.net.normcore.iorder.entity.BaseEntity;
import cn.net.normcore.iorder.entity.business.Shop;

import javax.persistence.*;
import java.util.Date;

/**
 * 顾客签到记录实体
 * Created by 81062 on 2017/3/16.
 */
@Entity
@Table(name = "sign_in_record")
public class SignInRecord extends BaseEntity {
    private Date signInTime;  //签到时间
    private Date signInDate;  //签到日期，每天只能签到一次
    private Customer customer;  //顾客
    private Shop shop;  //签到的店铺

    @Column(name = "sign_in_time", nullable = false, updatable = false)
    @Temporal(TemporalType.TIMESTAMP)
    public Date getSignInTime() {
        return signInTime;
    }

    public void setSignInTime(Date signInTime) {
        this.signInTime = signInTime;
    }

    @Column(name = "sign_in_date", nullable = false, updatable = false)
    @Temporal(TemporalType.DATE)
    public Date getSignInDate() {
        return signInDate;
    }

    public void setSignInDate(Date signInDate) {
        this.signInDate = signInDate;
    }

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "customer_id", referencedColumnName = "id")
    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "shop_id", referencedColumnName = "id")
    public Shop getShop() {
        return shop;
    }

    public void setShop(Shop shop) {
        this.shop = shop;
    }
}
