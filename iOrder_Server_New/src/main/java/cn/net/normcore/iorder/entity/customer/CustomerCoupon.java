package cn.net.normcore.iorder.entity.customer;

import cn.net.normcore.iorder.entity.BaseEntity;
import cn.net.normcore.iorder.entity.business.Coupon;

import javax.persistence.*;

/**
 * 顾客优惠券关联实体，即顾客优惠券领取记录
 * Created by 81062 on 2017/3/16.
 */
@Entity
@Table(name = "customer_coupon")
public class CustomerCoupon extends BaseEntity {
    private Character status;  //状态，1-未使用，2-已使用，3-已过期
    private Customer customer;  //顾客
    private Coupon coupon;  //优惠券

    @Column(name = "status", nullable = false)
    public Character getStatus() {
        return status;
    }

    public void setStatus(Character status) {
        this.status = status;
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
    @JoinColumn(name = "coupon_id", referencedColumnName = "id")
    public Coupon getCoupon() {
        return coupon;
    }

    public void setCoupon(Coupon coupon) {
        this.coupon = coupon;
    }
}
