package cn.net.normcore.iorder.entity.goods;

import cn.net.normcore.iorder.entity.BaseEntity;
import cn.net.normcore.iorder.entity.business.Shop;

import javax.persistence.*;

/**
 * 商品实体
 * Created by 81062 on 2017/3/15.
 */
@Entity
@Table(name = "goods")
public class Goods extends BaseEntity {
    private String name;  //商品名称
    private Float originalPrice;  //商品原始价格
    private Float nowPrice;  //商品当前价格
    private String picture;  //商品图片
    private Integer commentAmount;  //商品已有评论数量
    private Integer praiseAmount;  //商品获得点赞数量
    private String adInfo;  //商品广告语
    private GoodsCategory category;  //商品所属分类
    private Shop shop;  //商品所属店铺

    @Column(name = "name", nullable = false, length = 50)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column(name = "original_price", nullable = false)
    public Float getOriginalPrice() {
        return originalPrice;
    }

    public void setOriginalPrice(Float originalPrice) {
        this.originalPrice = originalPrice;
    }

    @Column(name = "now_price", nullable = false)
    public Float getNowPrice() {
        return nowPrice;
    }

    public void setNowPrice(Float nowPrice) {
        this.nowPrice = nowPrice;
    }

    @Column(name = "picture", length = 100)
    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    @Column(name = "comment_amount", nullable = false)
    public Integer getCommentAmount() {
        return commentAmount;
    }

    public void setCommentAmount(Integer commentAmount) {
        this.commentAmount = commentAmount;
    }

    @Column(name = "praise_amount", nullable = false)
    public Integer getPraiseAmount() {
        return praiseAmount;
    }

    public void setPraiseAmount(Integer praiseAmount) {
        this.praiseAmount = praiseAmount;
    }

    @Column(name = "ad_info", length = 100)
    public String getAdInfo() {
        return adInfo;
    }

    public void setAdInfo(String adInfo) {
        this.adInfo = adInfo;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id", referencedColumnName = "id")
    public GoodsCategory getCategory() {
        return category;
    }

    public void setCategory(GoodsCategory category) {
        this.category = category;
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
