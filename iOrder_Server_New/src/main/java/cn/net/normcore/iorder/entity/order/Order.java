package cn.net.normcore.iorder.entity.order;

import cn.net.normcore.iorder.entity.BaseEntity;
import cn.net.normcore.iorder.entity.business.Coupon;
import cn.net.normcore.iorder.entity.customer.Customer;

import javax.persistence.*;
import java.util.Date;

/**
 * 订单实体
 * Created by 81062 on 2017/3/15.
 */
@Entity
@Table(name = "[order]")
public class Order extends BaseEntity {
    private String code;  //订单编号
    private Character status;  //订单状态，0-已取消，1-已下单未支付，2-已支付待接单，3-已接单制作中，4-制作完成待取货，5-已取货待评价，6-已评价订单完成
    private Date orderTime;  //下单时间
    private Date payTime;  //支付时间
    private Date receiveTime;  //接单时间
    private Date completeTime;  //商品制作完成时间
    private Date getTime;  //取货时间
    private Date cancelTime;  //订单取消时间
    private Float totalPrice;  //订单总金额
    private Float payPrice;  //订单实际支付金额
    private Customer customer;  //订单所属用户
    private Coupon coupon;  //订单使用的优惠券，空表示没使用优惠券

    @Column(name = "code", length = 20, nullable = false, unique = true)
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @Column(name = "status", nullable = false)
    public Character getStatus() {
        return status;
    }

    public void setStatus(Character status) {
        this.status = status;
    }

    @Column(name = "order_time", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    public Date getOrderTime() {
        return orderTime;
    }

    public void setOrderTime(Date orderTime) {
        this.orderTime = orderTime;
    }

    @Column(name = "pay_time")
    @Temporal(TemporalType.TIMESTAMP)
    public Date getPayTime() {
        return payTime;
    }

    public void setPayTime(Date payTime) {
        this.payTime = payTime;
    }

    @Column(name = "receive_time")
    @Temporal(TemporalType.TIMESTAMP)
    public Date getReceiveTime() {
        return receiveTime;
    }

    public void setReceiveTime(Date receiveTime) {
        this.receiveTime = receiveTime;
    }

    @Column(name = "complete_time")
    @Temporal(TemporalType.TIMESTAMP)
    public Date getCompleteTime() {
        return completeTime;
    }

    public void setCompleteTime(Date completeTime) {
        this.completeTime = completeTime;
    }

    @Column(name = "get_time")
    @Temporal(TemporalType.TIMESTAMP)
    public Date getGetTime() {
        return getTime;
    }

    public void setGetTime(Date getTime) {
        this.getTime = getTime;
    }

    @Column(name = "cancel_time")
    @Temporal(TemporalType.TIMESTAMP)
    public Date getCancelTime() {
        return cancelTime;
    }

    public void setCancelTime(Date cancelTime) {
        this.cancelTime = cancelTime;
    }

    @Column(name = "total_price", nullable = false)
    public Float getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Float totalPrice) {
        this.totalPrice = totalPrice;
    }

    @Column(name = "pay_price")
    public Float getPayPrice() {
        return payPrice;
    }

    public void setPayPrice(Float payPrice) {
        this.payPrice = payPrice;
    }

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "customer_id", referencedColumnName = "id")
    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "coupon_id", referencedColumnName = "id")
    public Coupon getCoupon() {
        return coupon;
    }

    public void setCoupon(Coupon coupon) {
        this.coupon = coupon;
    }
}
