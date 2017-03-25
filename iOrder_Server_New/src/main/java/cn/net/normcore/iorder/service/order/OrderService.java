package cn.net.normcore.iorder.service.order;

import cn.net.normcore.iorder.entity.order.Order;
import cn.net.normcore.iorder.entity.order.OrderItem;
import cn.net.normcore.iorder.service.BaseService;
import com.fasterxml.jackson.databind.JsonNode;

import java.util.List;

/**
 * Created by 81062 on 2017/3/19.
 */
public interface OrderService extends BaseService<Order, Long> {

    /**
     * 顾客添加商品到购物车
     * 如果购物车中已存在该商品，则叠加数量
     *
     * @param customerId 顾客ID
     * @param goodsId    商品ID
     * @param amount     数量
     */
    void addItem(Long customerId, Long goodsId, Integer amount);

    /**
     * 删除购物车项
     *
     * @param customerId 顾客ID
     * @param goodsId    商品ID
     */
    void deleteItem(Long customerId, Long goodsId);

    /**
     * 减少购物车项的商品数量
     * 如果商品数量减少到0则删除购物车项
     *
     * @param customerId 顾客ID
     * @param goodsId    商品ID
     * @param amount     需要减少的数量
     */
    void dropItemAmount(Long customerId, Long goodsId, Integer amount);

    /**
     * 把顾客在某店铺的购物车中的商品生成订单
     *
     * @param customerId 顾客ID
     * @param shopId     店铺ID
     * @param couponId   使用的优惠券ID
     * @return 生成的订单信息
     */
    Order generateShopOrder(Long customerId, Long shopId, Long couponId);

    /**
     * 获取顾客的订单列表，按时间降序排列
     *
     * @param customerId 顾客ID
     * @return
     */
    List<Order> customerList(Long customerId);

    /**
     * 支付订单
     *
     * @param orderId
     */
    void pay(Long orderId);

    /**
     * 获取订单项的总金额
     *
     * @param orderItems
     * @return
     */
    Float getItemsTotalPrice(List<OrderItem> orderItems);

    /**
     * 下单，根据提交的json数据生成订单
     *
     * @param data
     * @return
     */
    Order order(JsonNode data, Long customerId);
}
