package cn.net.normcore.iorder.repository.order;

import cn.net.normcore.iorder.entity.order.OrderItem;
import cn.net.normcore.iorder.repository.BaseRepository;

import java.util.List;

/**
 * Created by 81062 on 2017/3/19.
 */
public interface OrderItemRepository extends BaseRepository<OrderItem, Long> {

    /**
     * 根据顾客和商品查询未下单订单项
     *
     * @param customerId 顾客ID
     * @param goodsId    商品ID
     * @return
     */
    OrderItem findByCustomerIdAndGoodsIdAndOrderIsNull(Long customerId, Long goodsId);

    /**
     * 根据顾客和店铺查询未下单订单项
     *
     * @param customerId 顾客ID
     * @param shopId     店铺ID
     * @return
     */
    List<OrderItem> findByCustomerIdAndShopIdAndOrderIsNull(Long customerId, Long shopId);
}
