package cn.net.normcore.iorder.repository.customer;

import cn.net.normcore.iorder.entity.customer.MarkedGoods;
import cn.net.normcore.iorder.repository.BaseRepository;

/**
 * Created by 81062 on 2017/3/19.
 */
public interface MarkedGoodsRepository extends BaseRepository<MarkedGoods, Long> {

    /**
     * 根据顾客ID和商品ID查找商品收藏记录
     *
     * @param customerId 顾客ID
     * @param goodsId    商品ID
     * @return
     */
    MarkedGoods findByCustomerIdAndGoodsId(Long customerId, Long goodsId);
}
