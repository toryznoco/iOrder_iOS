package cn.net.normcore.iorder.repository.customer;

import cn.net.normcore.iorder.entity.customer.MarkedShop;
import cn.net.normcore.iorder.repository.BaseRepository;

/**
 * Created by 81062 on 2017/3/19.
 */
public interface MarkedShopRepository extends BaseRepository<MarkedShop, Long> {

    /**
     * 根据顾客ID和店铺ID查询
     *
     * @param customerId 顾客ID
     * @param shopId     店铺ID
     * @return
     */
    MarkedShop findByCustomerIdAndShopId(Long customerId, Long shopId);
}
