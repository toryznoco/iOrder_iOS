package cn.net.normcore.iorder.entity.business;

import cn.net.normcore.iorder.entity.BaseEntity;
import cn.net.normcore.iorder.entity.goods.Goods;
import cn.net.normcore.iorder.entity.goods.GoodsCategory;
import cn.net.normcore.iorder.entity.ibeacon.IBeacon;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Date;
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
    private Double xCoord;  //商铺所在位置经度，正数表示东经，负数表示西经，如：东经113.15°：113.15 西经113.15°：-113.15
    private Double yCoord;  //商铺所在位置纬度，正数表示北纬，负数表示南纬，如：北纬45.15°：45.15 南纬45.15°：-45.15
    private String cheapInfo;  //商铺当前优惠信息，或者说广告语
    private Integer totalSale;  //商铺销售总量
    private String picture;  //商铺展示图片
    private String headImage;  //商铺头像
    private Float personalPrice;  //人均消费，或者说多少钱一人
    private String detailBackImage;  //店铺详情页面背景图片
    private Float score;  //综合评分
    private Date openTime;  //每日开门时间
    private Date closeTime;  //每日关门时间
    private String phone;  //店铺电话
    private String notice;  //店铺公告
    private Boolean payOnline;  //是否支持在线支付
    private int distance;  //距离
    private boolean isTodaySigned;  //今日是否已签到
    private Shopman shopman;  //店铺账号
    private List<IBeacon> iBeacons;  //店铺的IBeacon列表
    private List<GoodsCategory> goodsCategories;  //店铺的商品分类列表
    private List<Goods> goods;  //店铺的商品列表
    private List<Coupon> coupons;  //店铺发布的优惠券列表

    /**
     * 获得店铺未分类的商品列表
     *
     * @return
     */
    public List<Goods> noCategoryGoods() {
        List<Goods> noCategoryGoods = new ArrayList<>();
        goods.forEach(g -> {
            if (g.getCategory() == null)
                noCategoryGoods.add(g);
        });
        return noCategoryGoods;
    }

    @Column(name = "detail_back_image", length = 100)
    public String getDetailBackImage() {
        return detailBackImage;
    }

    public void setDetailBackImage(String detailBackImage) {
        this.detailBackImage = detailBackImage;
    }

    @Column(name = "score", nullable = false)
    public Float getScore() {
        return score;
    }

    public void setScore(Float score) {
        this.score = score;
    }

    @Column(name = "open_time")
    @Temporal(TemporalType.TIME)
    public Date getOpenTime() {
        return openTime;
    }

    public void setOpenTime(Date openTime) {
        this.openTime = openTime;
    }

    @Column(name = "close_time")
    @Temporal(TemporalType.TIME)
    public Date getCloseTime() {
        return closeTime;
    }

    public void setCloseTime(Date closeTime) {
        this.closeTime = closeTime;
    }

    @Column(name = "phone", length = 50)
    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Column(name = "notice", length = 100)
    public String getNotice() {
        return notice;
    }

    public void setNotice(String notice) {
        this.notice = notice;
    }

    @Column(name = "pay_online", nullable = false)
    public Boolean getPayOnline() {
        return payOnline;
    }

    public void setPayOnline(Boolean payOnline) {
        this.payOnline = payOnline;
    }

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
    public Double getxCoord() {
        return xCoord;
    }

    public void setxCoord(Double xCoord) {
        this.xCoord = xCoord;
    }

    @Column(name = "coord_y")
    public Double getyCoord() {
        return yCoord;
    }

    public void setyCoord(Double yCoord) {
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

    @Transient
    public int getDistance() {
        return distance;
    }

    public void setDistance(int distance) {
        this.distance = distance;
    }

    @Transient
    public boolean isTodaySigned() {
        return isTodaySigned;
    }

    public void setTodaySigned(boolean todaySigned) {
        isTodaySigned = todaySigned;
    }

    @OneToOne(mappedBy = "shop", fetch = FetchType.LAZY, optional = false)
    public Shopman getShopman() {
        return shopman;
    }

    public void setShopman(Shopman shopman) {
        this.shopman = shopman;
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
