package cn.net.normcore.iorder.entity.goods;

import cn.net.normcore.iorder.entity.BaseEntity;
import cn.net.normcore.iorder.entity.business.Shop;

import javax.persistence.*;

/**
 * 商品分类实体
 * Created by 81062 on 2017/3/15.
 */
@Entity
@Table(name = "goods_category")
public class GoodsCategory extends BaseEntity {
    private String name;  //分类名称
    private String description;  //备注信息
    private Shop shop;  //所属店铺

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

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "shop_id", referencedColumnName = "id")
    public Shop getShop() {
        return shop;
    }

    public void setShop(Shop shop) {
        this.shop = shop;
    }
}
