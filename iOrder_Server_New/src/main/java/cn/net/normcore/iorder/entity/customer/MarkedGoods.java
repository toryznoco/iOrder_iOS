package cn.net.normcore.iorder.entity.customer;

import cn.net.normcore.iorder.entity.BaseEntity;
import cn.net.normcore.iorder.entity.goods.Goods;

import javax.persistence.*;

/**
 * 商品收藏实体
 * Created by 81062 on 2017/3/16.
 */
@Entity
@Table(name = "marked_goods")
public class MarkedGoods extends BaseEntity {
    private String remarks;  //备注
    private Customer customer;  //收藏人
    private Goods goods;  //收藏的商品

    @Column(name = "remarks", length = 100)
    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "customer_id", referencedColumnName = "id")
    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "goods_id", referencedColumnName = "id")
    public Goods getGoods() {
        return goods;
    }

    public void setGoods(Goods goods) {
        this.goods = goods;
    }
}
