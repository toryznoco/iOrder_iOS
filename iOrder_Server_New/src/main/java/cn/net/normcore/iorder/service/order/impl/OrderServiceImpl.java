package cn.net.normcore.iorder.service.order.impl;

import cn.net.normcore.iorder.entity.business.Shop;
import cn.net.normcore.iorder.entity.business.Shopman;
import cn.net.normcore.iorder.entity.customer.Customer;
import cn.net.normcore.iorder.entity.goods.Goods;
import cn.net.normcore.iorder.entity.order.Order;
import cn.net.normcore.iorder.entity.order.OrderItem;
import cn.net.normcore.iorder.repository.order.OrderRepository;
import cn.net.normcore.iorder.service.BaseServiceImpl;
import cn.net.normcore.iorder.service.business.CouponService;
import cn.net.normcore.iorder.service.business.ShopService;
import cn.net.normcore.iorder.service.business.ShopmanService;
import cn.net.normcore.iorder.service.customer.CustomerService;
import cn.net.normcore.iorder.service.goods.GoodsService;
import cn.net.normcore.iorder.service.order.OrderItemService;
import cn.net.normcore.iorder.service.order.OrderService;
import com.fasterxml.jackson.databind.JsonNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
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
    @Autowired
    private ShopmanService shopmanService;

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
            order.generateCode();
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

    @Override
    @Transactional
    public Order order(JsonNode data, Long customerId) {
        JsonNode shopId = data.get("shopId");
        if (shopId == null)
            return null;
        Shop shop = shopService.get(shopId.asLong());
        if (shop == null)
            return null;
        Customer customer = customerService.get(customerId);
        Iterator<JsonNode> itemsIterator = data.get("items").iterator();
        if (!itemsIterator.hasNext())
            return null;
        List<OrderItem> orderItems = new ArrayList<>();
        while (itemsIterator.hasNext()) {
            JsonNode node = itemsIterator.next();
            OrderItem item = new OrderItem();
            JsonNode amount = node.get("amount");
            if (amount == null || amount.asInt() <= 0)
                return null;
            item.setAmount(amount.asInt());
            Goods goods = goodsService.get(node.get("goodsId").asLong());
            if (goods == null || !goods.getShop().getId().equals(shop.getId()))
                return null;
            item.setGoods(goods);
            item.setShop(goods.getShop());
            item.setCustomer(customer);
            item.readyInert();
            orderItems.add(item);
        }
        Order order = new Order();
        order.setShop(shop);
        order.setCustomer(customer);
        order.bindOrderItems(orderItems);
        order.setGoodsAmount(getOrderGoodsAmount(order));
        order.setStatus(Character.valueOf('1'));
        order.generateCode();
        JsonNode couponId = data.get("couponId");
        if (couponId != null)
            order.setCoupon(couponService.get(couponId.asLong()));
        order.setOrderTime(new Date());
        order.setTotalPrice(getItemsTotalPrice(orderItems));
        order.setPayPrice(order.getTotalPrice() - (order.getCoupon() == null ? 0 : order.getCoupon().getMoney()));
        save(order);
        return order;
    }

    @Override
    @Transactional
    public void take(Long orderId) {
        Order order = get(orderId);
        order.setGetTime(new Date());
        order.setStatus(Character.valueOf('5'));
        save(order);
    }

    @Override
    public List<Order> findShopAll(Long shopmanId) {
        Shopman shopman = shopmanService.get(shopmanId);
        List<Order> orders = repository.findByShopOrderByCreateTimeDesc(shopman.getShop());
        orders.forEach(order -> order.setGoodsAmount(getOrderGoodsAmount(order)));
        return orders;
    }

    @Override
    @Transactional
    public void cancel(Long orderId) {
        Order order = get(orderId);
        order.setCancelTime(new Date());
        order.setStatus(Character.valueOf('0'));
        save(order);
    }

    @Override
    @Transactional
    public void receive(Long orderId) {
        Order order = get(orderId);
        order.setReceiveTime(new Date());
        order.setStatus(Character.valueOf('3'));
        save(order);
    }

    @Override
    @Transactional
    public void complete(Long orderId) {
        Order order = get(orderId);
        order.setCompleteTime(new Date());
        order.setStatus(Character.valueOf('4'));
        save(order);
    }

}
