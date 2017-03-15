package cn.net.normcore.iorder.entity.promotion;

import cn.net.normcore.iorder.entity.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * 推广信息实体
 * Created by 81062 on 2017/3/16.
 */
@Entity
@Table(name = "promotion")
public class Promotion extends BaseEntity {
    private String picture;  //图片
    private String goToUrl;  //点击跳转地址
    private Character type;  //类型，1-首页轮播，2-周末特惠，3-天天特价，4-新品推荐
    private String description;  //描述信息

    @Column(name = "picture", nullable = false, length = 100)
    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    @Column(name = "go_to_url")
    public String getGoToUrl() {
        return goToUrl;
    }

    public void setGoToUrl(String goToUrl) {
        this.goToUrl = goToUrl;
    }

    @Column(name = "type", nullable = false)
    public Character getType() {
        return type;
    }

    public void setType(Character type) {
        this.type = type;
    }

    @Column(name = "description", length = 100)
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
