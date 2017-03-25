package cn.net.normcore.iorder.service;

import cn.net.normcore.iorder.common.exception.EntityConvertorException;
import cn.net.normcore.iorder.common.exception.IdNotFoundException;
import cn.net.normcore.iorder.common.exception.NullFieldException;
import cn.net.normcore.iorder.common.exception.ValueCanNotBeException;
import cn.net.normcore.iorder.entity.business.Shop;
import cn.net.normcore.iorder.entity.customer.Customer;
import cn.net.normcore.iorder.entity.goods.Goods;
import cn.net.normcore.iorder.entity.order.Order;
import cn.net.normcore.iorder.entity.order.OrderItem;
import cn.net.normcore.iorder.service.business.ShopService;
import cn.net.normcore.iorder.service.goods.GoodsService;
import cn.net.normcore.iorder.service.order.OrderService;
import com.fasterxml.jackson.databind.JsonNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

/**
 * 实体转换器，把前台提交的json数据转换成实体对象
 * Created by 81062 on 2017/3/24.
 */
@Service
public class EntityConvertor {
    @Autowired
    private GoodsService goodsService;
    @Autowired
    private ShopService shopService;
    @Autowired
    private OrderService orderService;

    public Order generateOrder(JsonNode data, Customer customer) throws EntityConvertorException {
        JsonNode items = data.get("items");
        if (items == null)
            throw new NullFieldException(Order.class.getSimpleName(), "items");
        Iterator<JsonNode> itemsIterator = items.iterator();
        if (!itemsIterator.hasNext())
            throw new EntityConvertorException(Order.class.getSimpleName(), "items", "订单没有订单项", 0, "订单必须含有订单项");
        List<OrderItem> orderItems = new ArrayList<>();
        while (itemsIterator.hasNext()) {
            OrderItem item = generateOrderItem(itemsIterator.next(), customer);
            item.readyInert();
            orderItems.add(item);
        }
        Order order = new Order();
        JsonNode shopId = data.get("shopId");
        if (shopId == null)
            throw new NullFieldException(Order.class.getSimpleName(), "shopId");
        Shop shop = shopService.get(shopId.asLong());
        if (shop == null)
            throw new IdNotFoundException(Shop.class.getSimpleName(), shopId.asLong());
        order.setShop(shop);
        order.setCustomer(customer);
        order.bindOrderItems(orderItems);
//        order.setGoodsAmount(orderService.getOrderGoodsAmount(order));
//        order.setStatus(Character.valueOf('1'));
//        order.generateCode();
//        JsonNode couponId = data.get("couponId");
//        if (couponId != null)
//            order.setCoupon(couponService.get(couponId.asLong()));
//        order.setOrderTime(new Date());
//        order.setTotalPrice(getItemsTotalPrice(orderItems));
//        order.setPayPrice(order.getTotalPrice() - (order.getCoupon() == null ? 0 : order.getCoupon().getMoney()));
//        save(order);
//        return order;
        return order;
    }

    /**
     * 把json数据转换成订单项对象
     *
     * @param data
     * @return
     */
    public OrderItem generateOrderItem(JsonNode data, Customer customer) throws EntityConvertorException {
        OrderItem item = new OrderItem();
        JsonNode amount = data.get("amount");
        if (amount == null)
            throw new NullFieldException(OrderItem.class.getSimpleName(), "amount");
        if (amount.asInt() <= 0)
            throw new ValueCanNotBeException(OrderItem.class.getSimpleName(), "amount", amount.asInt());
        item.setAmount(amount.asInt());
        JsonNode goodsId = data.get("goodsId");
        if (goodsId == null)
            throw new NullFieldException(OrderItem.class.getSimpleName(), "goodsId");
        Goods goods = goodsService.get(goodsId.asLong());
        if (goods == null)
            throw new IdNotFoundException(Goods.class.getSimpleName(), goodsId.asLong());
        item.setGoods(goods);
        item.setShop(goods.getShop());
        item.setCustomer(customer);
        item.readyInert();
        return item;
    }
}
