package cn.net.normcore.iorder.vo.order;

import cn.net.normcore.iorder.entity.order.OrderItem;
import cn.net.normcore.iorder.vo.BaseVo;
import cn.net.normcore.iorder.vo.goods.GoodsVo;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by 81062 on 2017/3/19.
 */
public class OrderItemVo extends BaseVo {
    private Integer amount;  //商品数量
    private String comment;  //评论内容
    private Date commentTime;  //评论时间
    private Integer score;  //评星
    private float totalPrice;  //订单项总金额
    private GoodsVo goods;  //商品信息

    public static List<OrderItemVo> listFromOrderItems(List<OrderItem> items) {
        List<OrderItemVo> itemVos = new ArrayList<>();
        items.forEach(item -> itemVos.add(fromOrderItem(item)));
        return itemVos;
    }

    public static OrderItemVo fromOrderItem(OrderItem item) {
        OrderItemVo itemVo = new OrderItemVo();
        itemVo.setId(item.getId());
        itemVo.setAmount(item.getAmount());
        itemVo.setComment(item.getComment());
        itemVo.setCommentTime(item.getCommentTime());
        itemVo.setScore(item.getScore());
        itemVo.setTotalPrice(item.getGoods().getNowPrice() * item.getAmount());
        itemVo.setGoods(GoodsVo.fromGoods(item.getGoods()));
        return itemVo;
    }

    public float getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(float totalPrice) {
        this.totalPrice = totalPrice;
    }

    public GoodsVo getGoods() {
        return goods;
    }

    public void setGoods(GoodsVo goods) {
        this.goods = goods;
    }

    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Date getCommentTime() {
        return commentTime;
    }

    public void setCommentTime(Date commentTime) {
        this.commentTime = commentTime;
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }
}
