package cn.net.normcore.iorder.service.order;

import cn.net.normcore.iorder.entity.order.OrderItem;
import cn.net.normcore.iorder.service.BaseService;

import java.util.List;

/**
 * Created by 81062 on 2017/3/19.
 */
public interface OrderItemService extends BaseService<OrderItem, Long> {

    /**
     * 查询顾客购物车中是否已有某商品
     *
     * @param customerId 顾客ID
     * @param goodsId    商品ID
     * @return
     */
    OrderItem findExists(Long customerId, Long goodsId);

    /**
     * 查询顾客在某店铺的未下单商品列表，即购物车项
     *
     * @param customerId 顾客ID
     * @param shopId     店铺ID
     * @return
     */
    List<OrderItem> findShopUnOrder(Long customerId, Long shopId);
}
