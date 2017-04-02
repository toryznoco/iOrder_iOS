package cn.net.normcore.iorder.repository.order;

import cn.net.normcore.iorder.entity.business.Shop;
import cn.net.normcore.iorder.entity.order.Order;
import cn.net.normcore.iorder.repository.BaseRepository;

import java.util.List;

/**
 * Created by 81062 on 2017/3/19.
 */
public interface OrderRepository extends BaseRepository<Order, Long> {

    /**
     * 根据顾客ID查询订单列表，按下单时间降序排列
     *
     * @param customerId 顾客ID
     * @return
     */
    List<Order> findByCustomerIdOrderByOrderTimeDesc(Long customerId);

    /**
     * 根据店铺查询订单列表，按订单生成时间降序排列
     *
     * @param shop
     * @return
     */
    List<Order> findByShopOrderByCreateTimeDesc(Shop shop);
}
