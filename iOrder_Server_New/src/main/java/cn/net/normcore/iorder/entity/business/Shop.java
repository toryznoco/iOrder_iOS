package cn.net.normcore.iorder.entity.business;

import cn.net.normcore.iorder.entity.BaseEntity;
import cn.net.normcore.iorder.entity.goods.Goods;
import cn.net.normcore.iorder.entity.goods.GoodsCategory;
import cn.net.normcore.iorder.entity.ibeacon.IBeacon;

import javax.persistence.*;
import java.util.List;

/**
 * 店铺实体类
 * Created by 81062 on 2017/3/15.
 */
@Entity
@Table(name = "shop")
public class Shop extends BaseEntity {
    private String name;  //商铺名称
    private String address;  //商铺地址
    private Float xCoord;  //商铺所在位置经度，正数表示东经，负数表示西经，如：东经113.15°：113.15 西经113.15°：-113.15
    private Float yCoord;  //商铺所在位置纬度，正数表示北纬，负数表示南纬，如：北纬45.15°：45.15 南纬45.15°：-45.15
    private String cheapInfo;  //商铺当前优惠信息，或者说广告语
    private Integer totalSale;  //商铺销售总量
    private String picture;  //商铺展示图片
    private String headImage;  //商铺头像
    private Float personalPrice;  //人均消费，或者说多少钱一人
    private List<IBeacon> iBeacons;  //店铺的IBeacon列表
    private List<GoodsCategory> goodsCategories;  //店铺的商品分类列表
    private List<Goods> goods;  //店铺的商品列表
    private List<Coupon> coupons;  //店铺发布的优惠券列表

    @Column(name = "name", nullable = false, length = 50)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column(name = "address", length = 100)
    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Column(name = "coord_x")
    public Float getxCoord() {
        return xCoord;
    }

    public void setxCoord(Float xCoord) {
        this.xCoord = xCoord;
    }

    @Column(name = "coord_y")
    public Float getyCoord() {
        return yCoord;
    }

    public void setyCoord(Float yCoord) {
        this.yCoord = yCoord;
    }

    @Column(name = "cheep_info", length = 100)
    public String getCheapInfo() {
        return cheapInfo;
    }

    public void setCheapInfo(String cheapInfo) {
        this.cheapInfo = cheapInfo;
    }

    @Column(name = "total_sale")
    public Integer getTotalSale() {
        return totalSale;
    }

    public void setTotalSale(Integer totalSale) {
        this.totalSale = totalSale;
    }

    @Column(name = "picture", length = 100)
    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    @Column(name = "head_image", length = 100)
    public String getHeadImage() {
        return headImage;
    }

    public void setHeadImage(String headImage) {
        this.headImage = headImage;
    }

    @Column(name = "personal_price")
    public Float getPersonalPrice() {
        return personalPrice;
    }

    public void setPersonalPrice(Float personalPrice) {
        this.personalPrice = personalPrice;
    }

    @OneToMany(mappedBy = "shop", fetch = FetchType.LAZY)
    public List<IBeacon> getiBeacons() {
        return iBeacons;
    }

    public void setiBeacons(List<IBeacon> iBeacons) {
        this.iBeacons = iBeacons;
    }

    @OneToMany(mappedBy = "shop", fetch = FetchType.LAZY)
    public List<GoodsCategory> getGoodsCategories() {
        return goodsCategories;
    }

    public void setGoodsCategories(List<GoodsCategory> goodsCategories) {
        this.goodsCategories = goodsCategories;
    }

    @OneToMany(mappedBy = "shop", fetch = FetchType.LAZY)
    public List<Goods> getGoods() {
        return goods;
    }

    public void setGoods(List<Goods> goods) {
        this.goods = goods;
    }

    @OneToMany(mappedBy = "shop", fetch = FetchType.LAZY)
    public List<Coupon> getCoupons() {
        return coupons;
    }

    public void setCoupons(List<Coupon> coupons) {
        this.coupons = coupons;
    }
}
