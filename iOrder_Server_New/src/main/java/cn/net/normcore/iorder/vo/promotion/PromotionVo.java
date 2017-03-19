package cn.net.normcore.iorder.vo.promotion;

import cn.net.normcore.iorder.entity.promotion.Promotion;
import cn.net.normcore.iorder.vo.BaseVo;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by 81062 on 2017/3/19.
 */
public class PromotionVo extends BaseVo {
    private String picture;  //图片
    private String goToUrl;  //点击跳转地址
    private Character type;  //类型，1-首页轮播，2-周末特惠，3-天天特价，4-新品推荐
    private String description;  //描述信息

    public static List<PromotionVo> listFromPromotions(List<Promotion> promotions) {
        List<PromotionVo> promotionVos = new ArrayList<>();
        promotions.forEach(promotion -> promotionVos.add(fromPromotion(promotion)));
        return promotionVos;
    }

    public static PromotionVo fromPromotion(Promotion promotion) {
        PromotionVo promotionVo = new PromotionVo();
        promotionVo.setId(promotion.getId());
        promotionVo.setPicture(promotion.getPicture());
        promotionVo.setGoToUrl(promotion.getGoToUrl());
        promotionVo.setType(promotion.getType());
        promotionVo.setDescription(promotion.getDescription());
        return promotionVo;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public String getGoToUrl() {
        return goToUrl;
    }

    public void setGoToUrl(String goToUrl) {
        this.goToUrl = goToUrl;
    }

    public Character getType() {
        return type;
    }

    public void setType(Character type) {
        this.type = type;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
