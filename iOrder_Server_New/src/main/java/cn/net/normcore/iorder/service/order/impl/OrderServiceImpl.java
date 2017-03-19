package cn.net.normcore.iorder.service.order.impl;

import cn.net.normcore.iorder.entity.goods.Goods;
import cn.net.normcore.iorder.entity.order.Order;
import cn.net.normcore.iorder.entity.order.OrderItem;
import cn.net.normcore.iorder.repository.order.OrderRepository;
import cn.net.normcore.iorder.service.BaseServiceImpl;
import cn.net.normcore.iorder.service.business.CouponService;
import cn.net.normcore.iorder.service.business.ShopService;
import cn.net.normcore.iorder.service.customer.CustomerService;
import cn.net.normcore.iorder.service.goods.GoodsService;
import cn.net.normcore.iorder.service.order.OrderItemService;
import cn.net.normcore.iorder.service.order.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

/**
 * Created by 81062 on 2017/3/19.
 */
@Service
@Transactional(readOnly = true)
public class OrderServiceImpl extends BaseServiceImpl<Order, Long, OrderRepository> implements OrderService {
    @Autowired
    private OrderItemService orderItemService;
    @Autowired
    private CustomerService customerService;
    @Autowired
    private GoodsService goodsService;
    @Autowired
    private CouponService couponService;
    @Autowired
    private ShopService shopService;

    /**
     * 重写get方法，计算出订单商品总数量
     *
     * @param id
     * @return
     */
    @Override
    public Order get(Long id) {
        Order order = super.get(id);
        order.setGoodsAmount(getOrderGoodsAmount(order));
        return order;
    }

    /**
     * 重写save方法，计算出订单商品总数量
     *
     * @param order
     * @return
     */
    @Override
    @Transactional
    public Order save(Order order) {
        Order o = super.save(order);
        o.setGoodsAmount(getOrderGoodsAmount(o));
        return o;
    }

    /**
     * 获取订单商品总数量
     *
     * @param order
     * @return
     */
    private int getOrderGoodsAmount(Order order) {
        int amount = 0;
        for (OrderItem item : order.getOrderItems()) {
            amount += item.getAmount();
        }
        return amount;
    }

    @Override
    @Transactional
    public void addItem(Long customerId, Long goodsId, Integer amount) {
        OrderItem orderItem = orderItemService.findExists(customerId, goodsId);
        if (orderItem == null) {
            orderItem = new OrderItem();
            orderItem.setCustomer(customerService.get(customerId));
            Goods goods = goodsService.get(goodsId);
            orderItem.setGoods(goods);
            orderItem.setShop(goods.getShop());
            orderItem.setAmount(amount);
        } else {
            orderItem.setAmount(orderItem.getAmount() + amount);
        }
        orderItemService.save(orderItem);
    }

    @Override
    @Transactional
    public void deleteItem(Long customerId, Long goodsId) {
        OrderItem orderItem = orderItemService.findExists(customerId, goodsId);
        if (orderItem != null)
            orderItemService.delete(orderItem);
    }

    @Override
    @Transactional
    public void dropItemAmount(Long customerId, Long goodsId, Integer amount) {
        OrderItem orderItem = orderItemService.findExists(customerId, goodsId);
        if (orderItem != null) {
            orderItem.setAmount(orderItem.getAmount() - amount);
            if (orderItem.getAmount() <= 0)
                orderItemService.delete(orderItem);
            else
                orderItemService.save(orderItem);
        }
    }

    @Override
    @Transactional
    public Order generateShopOrder(Long customerId, Long shopId, Long couponId) {
        List<OrderItem> orderItems = orderItemService.findShopUnOrder(customerId, shopId);
        if (!orderItems.isEmpty()) {
            Order order = new Order();
            order.setCustomer(customerService.get(customerId));
            order.setCode(String.valueOf(System.currentTimeMillis()));
            if (couponId != null)
                order.setCoupon(couponService.get(couponId));
            order.setShop(shopService.get(shopId));
            order.setOrderTime(new Date());
            order.setTotalPrice(getItemsTotalPrice(orderItems));
            order.setPayPrice(order.getTotalPrice() - (order.getCoupon() == null ? 0 : order.getCoupon().getMoney()));
            order.setStatus(Character.valueOf('1'));
            order.bindOrderItems(orderItems);
            save(order);
            return order;
        }
        return null;
    }

    @Override
    public List<Order> customerList(Long customerId) {
        List<Order> orders = repository.findByCustomerIdOrderByOrderTimeDesc(customerId);
        orders.forEach(order -> order.setGoodsAmount(getOrderGoodsAmount(order)));
        return orders;
    }

    @Override
    @Transactional
    public void pay(Long orderId) {
        Order order = get(orderId);
        order.setPayTime(new Date());
        order.setStatus(Character.valueOf('2'));
        save(order);
    }

    @Override
    public Float getItemsTotalPrice(List<OrderItem> orderItems) {
        Float totalPrice = Float.valueOf(0);
        for (OrderItem item :
                orderItems) {
            totalPrice += item.getGoods().getNowPrice() * item.getAmount();
        }
        return totalPrice;
    }

}
