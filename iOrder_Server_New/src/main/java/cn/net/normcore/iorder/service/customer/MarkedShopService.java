package cn.net.normcore.iorder.service.customer;

import cn.net.normcore.iorder.entity.customer.MarkedShop;
import cn.net.normcore.iorder.service.BaseService;

/**
 * Created by 81062 on 2017/3/19.
 */
public interface MarkedShopService extends BaseService<MarkedShop, Long> {

    /**
     * 查找已存在的店铺收藏记录
     *
     * @param customerId 顾客ID
     * @param shopId     店铺ID
     * @return
     */
    MarkedShop findExists(Long customerId, Long shopId);
}
