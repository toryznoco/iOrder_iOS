package cn.net.normcore.iorder.entity.customer;

import cn.net.normcore.iorder.entity.BaseEntity;
import cn.net.normcore.iorder.entity.business.Shop;

import javax.persistence.*;

/**
 * 店铺收藏实体
 * Created by 81062 on 2017/3/16.
 */
@Entity
@Table(name = "marked_shop")
public class MarkedShop extends BaseEntity {
    private String remarks;  //备注
    private Shop shop;  //收藏的店铺
    private Customer customer;  //收藏人

    @Column(name = "remarks", length = 100)
    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "shop_id", referencedColumnName = "id")
    public Shop getShop() {
        return shop;
    }

    public void setShop(Shop shop) {
        this.shop = shop;
    }

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "customer_id", referencedColumnName = "id")
    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }
}
