package cn.net.normcore.iorder.vo.order;

import cn.net.normcore.iorder.entity.order.Order;
import cn.net.normcore.iorder.vo.BaseVo;
import cn.net.normcore.iorder.vo.business.ShopVo;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by 81062 on 2017/3/19.
 */
public class OrderVo extends BaseVo {
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
    private int goodsAmount;  //订单商品总数量
    private ShopVo shop;  //订单所属店铺信息
    private String customerName;  //顾客姓名

    public static List<OrderVo> listFromOrders(List<Order> orders) {
        List<OrderVo> orderVos = new ArrayList<>();
        orders.forEach(order -> orderVos.add(fromOrder(order)));
        return orderVos;
    }

    public static OrderVo fromOrder(Order order) {
        OrderVo orderVo = new OrderVo();
        orderVo.setId(order.getId());
        orderVo.setCode(order.getCode());
        orderVo.setStatus(order.getStatus());
        orderVo.setOrderTime(order.getOrderTime());
        orderVo.setPayTime(order.getPayTime());
        orderVo.setReceiveTime(order.getReceiveTime());
        orderVo.setCompleteTime(order.getCompleteTime());
        orderVo.setGetTime(order.getGetTime());
        orderVo.setCancelTime(order.getCancelTime());
        orderVo.setTotalPrice(order.getTotalPrice());
        orderVo.setPayPrice(order.getPayPrice());
        orderVo.setGoodsAmount(order.getGoodsAmount());
        orderVo.setShop(ShopVo.fromShop(order.getShop()));
        orderVo.setCustomerName(order.getCustomer().getNickName());
        return orderVo;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public ShopVo getShop() {
        return shop;
    }

    public void setShop(ShopVo shop) {
        this.shop = shop;
    }

    public int getGoodsAmount() {
        return goodsAmount;
    }

    public void setGoodsAmount(int goodsAmount) {
        this.goodsAmount = goodsAmount;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Character getStatus() {
        return status;
    }

    public void setStatus(Character status) {
        this.status = status;
    }

    public Date getOrderTime() {
        return orderTime;
    }

    public void setOrderTime(Date orderTime) {
        this.orderTime = orderTime;
    }

    public Date getPayTime() {
        return payTime;
    }

    public void setPayTime(Date payTime) {
        this.payTime = payTime;
    }

    public Date getReceiveTime() {
        return receiveTime;
    }

    public void setReceiveTime(Date receiveTime) {
        this.receiveTime = receiveTime;
    }

    public Date getCompleteTime() {
        return completeTime;
    }

    public void setCompleteTime(Date completeTime) {
        this.completeTime = completeTime;
    }

    public Date getGetTime() {
        return getTime;
    }

    public void setGetTime(Date getTime) {
        this.getTime = getTime;
    }

    public Date getCancelTime() {
        return cancelTime;
    }

    public void setCancelTime(Date cancelTime) {
        this.cancelTime = cancelTime;
    }

    public Float getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Float totalPrice) {
        this.totalPrice = totalPrice;
    }

    public Float getPayPrice() {
        return payPrice;
    }

    public void setPayPrice(Float payPrice) {
        this.payPrice = payPrice;
    }
}
