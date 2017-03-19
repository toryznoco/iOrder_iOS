package cn.net.normcore.iorder.service.customer;

import cn.net.normcore.iorder.entity.customer.MarkedGoods;
import cn.net.normcore.iorder.service.BaseService;

/**
 * Created by 81062 on 2017/3/19.
 */
public interface MarkedGoodsService extends BaseService<MarkedGoods, Long> {

    /**
     * 查找已存在的商品收藏记录
     *
     * @param customerId 顾客ID
     * @param goodsId    商品ID
     * @return
     */
    MarkedGoods findExists(Long customerId, Long goodsId);
}
