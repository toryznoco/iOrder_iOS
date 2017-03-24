package cn.net.normcore.iorder.vo.token;

import cn.net.normcore.iorder.entity.BaseEntity;
import cn.net.normcore.iorder.entity.business.Shopman;
import cn.net.normcore.iorder.entity.customer.Customer;

/**
 * 用户类型
 * Created by 81062 on 2017/3/21.
 */
public enum UserType {
    CUSTOMER,  //顾客
    SHOPMAN,  //店主
    UNKNOWN;  //未知

    public static <E extends BaseEntity> UserType fromUser(E user) {
        if (user instanceof Customer)
            return CUSTOMER;
        if (user instanceof Shopman)
            return SHOPMAN;
        return UNKNOWN;
    }
}
