package cn.net.normcore.iorder.vo.goods;

import cn.net.normcore.iorder.entity.goods.Goods;
import cn.net.normcore.iorder.vo.BaseVo;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by 81062 on 2017/3/18.
 */
public class GoodsVo extends BaseVo {
    private String name;  //商品名称
    private Float originalPrice;  //商品原始价格
    private Float nowPrice;  //商品当前价格
    private String picture;  //商品图片
    private Integer commentAmount;  //商品已有评论数量
    private Integer praiseAmount;  //商品获得点赞数量
    private Integer monthSale;  //当月销售数量
    private String adInfo;  //商品广告语

    public static List<GoodsVo> listFromGoods(List<Goods> goodsList) {
        List<GoodsVo> goodsVos = new ArrayList<>();
        goodsList.forEach(goods -> goodsVos.add(fromGoods(goods)));
        return goodsVos;
    }

    public static GoodsVo fromGoods(Goods goods) {
        GoodsVo goodsVo = new GoodsVo();
        goodsVo.setId(goods.getId());
        goodsVo.setName(goods.getName());
        goodsVo.setOriginalPrice(goods.getOriginalPrice());
        goodsVo.setNowPrice(goods.getNowPrice());
        goodsVo.setPicture(goods.getPicture());
        goodsVo.setCommentAmount(goods.getCommentAmount());
        goodsVo.setPraiseAmount(goods.getPraiseAmount());
        goodsVo.setMonthSale(goods.getMonthSale());
        goodsVo.setAdInfo(goods.getAdInfo());
        return goodsVo;
    }

    public Integer getMonthSale() {
        return monthSale;
    }

    public void setMonthSale(Integer monthSale) {
        this.monthSale = monthSale;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Float getOriginalPrice() {
        return originalPrice;
    }

    public void setOriginalPrice(Float originalPrice) {
        this.originalPrice = originalPrice;
    }

    public Float getNowPrice() {
        return nowPrice;
    }

    public void setNowPrice(Float nowPrice) {
        this.nowPrice = nowPrice;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public Integer getCommentAmount() {
        return commentAmount;
    }

    public void setCommentAmount(Integer commentAmount) {
        this.commentAmount = commentAmount;
    }

    public Integer getPraiseAmount() {
        return praiseAmount;
    }

    public void setPraiseAmount(Integer praiseAmount) {
        this.praiseAmount = praiseAmount;
    }

    public String getAdInfo() {
        return adInfo;
    }

    public void setAdInfo(String adInfo) {
        this.adInfo = adInfo;
    }

}
