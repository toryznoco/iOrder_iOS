package cn.net.normcore.iorder.entity.business;

import cn.net.normcore.iorder.entity.BaseEntity;
import cn.net.normcore.iorder.entity.goods.GoodsCategory;

import javax.persistence.*;
import java.util.Date;

/**
 * 优惠券实体
 * Created by 81062 on 2017/3/15.
 */
@Entity
@Table(name = "coupon")
public class Coupon extends BaseEntity {
    private String name;  //优惠券名称
    private String description;  //描述信息
    private Float leastConsume;  //优惠券所需最低消费
    private Float money;  //优惠券金额
    private Date publishTime;  //优惠券发布时间
    private Date deadline;  //优惠券过期时间
    private Integer duration;  //优惠券有效时间，单位小时
    private Integer amount;  //优惠券总数量
    private Integer remain;  //优惠券剩余数量
    private Character status;  //1-有效期内，2-已过期
    private Shop shop;  //优惠券所属商铺
    private GoodsCategory goodsCategory;  //优惠券可用商品分类，空表示无商品类别限制

    @Column(name = "name", length = 50, nullable = false)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column(name = "description", length = 100)
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Column(name = "least_consume")
    public Float getLeastConsume() {
        return leastConsume;
    }

    public void setLeastConsume(Float leastConsume) {
        this.leastConsume = leastConsume;
    }

    @Column(name = "money", nullable = false)
    public Float getMoney() {
        return money;
    }

    public void setMoney(Float money) {
        this.money = money;
    }

    @Column(name = "publish_time", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    public Date getPublishTime() {
        return publishTime;
    }

    public void setPublishTime(Date publishTime) {
        this.publishTime = publishTime;
    }

    @Column(name = "deadline")
    @Temporal(TemporalType.TIMESTAMP)
    public Date getDeadline() {
        return deadline;
    }

    public void setDeadline(Date deadline) {
        this.deadline = deadline;
    }

    @Column(name = "duration")
    public Integer getDuration() {
        return duration;
    }

    public void setDuration(Integer duration) {
        this.duration = duration;
    }

    @Column(name = "amount", nullable = false)
    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    @Column(name = "remain", nullable = false)
    public Integer getRemain() {
        return remain;
    }

    public void setRemain(Integer remain) {
        this.remain = remain;
    }

    @Column(name = "status", nullable = false)
    public Character getStatus() {
        return status;
    }

    public void setStatus(Character status) {
        this.status = status;
    }

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "shop_id", referencedColumnName = "id")
    public Shop getShop() {
        return shop;
    }

    public void setShop(Shop shop) {
        this.shop = shop;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "goods_category_id", referencedColumnName = "id")
    public GoodsCategory getGoodsCategory() {
        return goodsCategory;
    }

    public void setGoodsCategory(GoodsCategory goodsCategory) {
        this.goodsCategory = goodsCategory;
    }
}
