package cn.net.normcore.iorder.vo.business;

import cn.net.normcore.iorder.entity.business.Shop;
import cn.net.normcore.iorder.vo.BaseVo;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by 81062 on 2017/3/18.
 */
public class ShopVo extends BaseVo {
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

    public static List<ShopVo> listFromShops(List<Shop> shops) {
        List<ShopVo> shopVos = new ArrayList<>();
        shops.forEach(shop -> shopVos.add(fromShop(shop)));
        return shopVos;
    }

    public static ShopVo fromShop(Shop shop) {
        ShopVo shopVo = new ShopVo();
        shopVo.setId(shop.getId());
        shopVo.setName(shop.getName());
        shopVo.setAddress(shop.getAddress());
        shopVo.setxCoord(shop.getxCoord());
        shopVo.setyCoord(shop.getyCoord());
        shopVo.setCheapInfo(shop.getCheapInfo());
        shopVo.setTotalSale(shop.getTotalSale());
        shopVo.setPicture(shop.getPicture());
        shopVo.setHeadImage(shop.getHeadImage());
        shopVo.setPersonalPrice(shop.getPersonalPrice());
        shopVo.setDetailBackImage(shop.getDetailBackImage());
        shopVo.setScore(shop.getScore());
        shopVo.setOpenTime(shop.getOpenTime());
        shopVo.setCloseTime(shop.getCloseTime());
        shopVo.setPhone(shop.getPhone());
        shopVo.setNotice(shop.getNotice());
        shopVo.setPayOnline(shop.getPayOnline());
        shopVo.setDistance(shop.getDistance());
        shopVo.setTodaySigned(shop.isTodaySigned());
        return shopVo;
    }

    public String getDetailBackImage() {
        return detailBackImage;
    }

    public void setDetailBackImage(String detailBackImage) {
        this.detailBackImage = detailBackImage;
    }

    public Float getScore() {
        return score;
    }

    public void setScore(Float score) {
        this.score = score;
    }

    public Date getOpenTime() {
        return openTime;
    }

    public void setOpenTime(Date openTime) {
        this.openTime = openTime;
    }

    public Date getCloseTime() {
        return closeTime;
    }

    public void setCloseTime(Date closeTime) {
        this.closeTime = closeTime;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getNotice() {
        return notice;
    }

    public void setNotice(String notice) {
        this.notice = notice;
    }

    public Boolean getPayOnline() {
        return payOnline;
    }

    public void setPayOnline(Boolean payOnline) {
        this.payOnline = payOnline;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Double getxCoord() {
        return xCoord;
    }

    public void setxCoord(Double xCoord) {
        this.xCoord = xCoord;
    }

    public Double getyCoord() {
        return yCoord;
    }

    public void setyCoord(Double yCoord) {
        this.yCoord = yCoord;
    }

    public String getCheapInfo() {
        return cheapInfo;
    }

    public void setCheapInfo(String cheapInfo) {
        this.cheapInfo = cheapInfo;
    }

    public Integer getTotalSale() {
        return totalSale;
    }

    public void setTotalSale(Integer totalSale) {
        this.totalSale = totalSale;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public String getHeadImage() {
        return headImage;
    }

    public void setHeadImage(String headImage) {
        this.headImage = headImage;
    }

    public Float getPersonalPrice() {
        return personalPrice;
    }

    public void setPersonalPrice(Float personalPrice) {
        this.personalPrice = personalPrice;
    }

    public int getDistance() {
        return distance;
    }

    public void setDistance(int distance) {
        this.distance = distance;
    }

    public boolean isTodaySigned() {
        return isTodaySigned;
    }

    public void setTodaySigned(boolean todaySigned) {
        isTodaySigned = todaySigned;
    }
}
