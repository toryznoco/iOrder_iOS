package cn.net.normcore.iorder.entity.ibeacon;

import cn.net.normcore.iorder.entity.BaseEntity;
import cn.net.normcore.iorder.entity.business.Shop;

import javax.persistence.*;

/**
 * IBeacon实体类
 * Created by 81062 on 2017/3/15.
 */
@Entity
@Table(name = "ibeacon")
public class IBeacon extends BaseEntity {
    private String uuid;  //UUID
    private String major;  //major
    private String minor;  //minor
    private Shop shop;  //所属商铺

    @Column(name = "uuid", length = 128, nullable = false)
    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    @Column(name = "major", length = 16, nullable = false)
    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major;
    }

    @Column(name = "minor", length = 16, nullable = false)
    public String getMinor() {
        return minor;
    }

    public void setMinor(String minor) {
        this.minor = minor;
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
