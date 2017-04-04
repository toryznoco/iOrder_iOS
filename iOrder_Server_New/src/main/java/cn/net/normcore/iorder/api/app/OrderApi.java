package cn.net.normcore.iorder.api.app;

import cn.net.normcore.iorder.common.SimpleResult;
import cn.net.normcore.iorder.entity.order.Order;
import cn.net.normcore.iorder.entity.order.OrderItem;
import cn.net.normcore.iorder.filter.ValidateToken;
import cn.net.normcore.iorder.service.order.OrderItemService;
import cn.net.normcore.iorder.service.order.OrderService;
import cn.net.normcore.iorder.vo.order.OrderItemVo;
import cn.net.normcore.iorder.vo.order.OrderVo;
import com.fasterxml.jackson.databind.JsonNode;
import org.hibernate.validator.constraints.NotBlank;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import javax.validation.constraints.NotNull;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/**
 * 订单相关接口
 * Created by 81062 on 2017/3/19.
 */
@Controller("appOrderApi")
@Path("/app/order")
@Produces(MediaType.APPLICATION_JSON)
@ValidateToken
public class OrderApi {
    @Autowired
    private OrderService orderService;
    @Autowired
    private OrderItemService orderItemService;

    /**
     * 顾客下单
     *
     * @param data
     * @param customerId
     * @return
     */
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public Map<String, Object> order(@NotNull JsonNode data, @HeaderParam("customerId") @NotNull Long customerId) {
        if (customerId == null)
            return SimpleResult.pessimistic(5000, "系统内部错误，请联系开发者");
        Order order = orderService.order(data, customerId);
        if (order == null)
            return SimpleResult.pessimistic(4012, "生成订单失败");
        Map<String, Object> result = SimpleResult.optimistic("生成订单成功");
        result.put("order", OrderVo.fromOrder(order));
        result.put("items", OrderItemVo.listFromOrderItems(order.getOrderItems()));
        return result;
    }

    /**
     * 顾客添加商品到购物车
     * 如果购物车中已经存在该商品，则叠加数量
     *
     * @param customerId 顾客ID，由TokenFilter放入请求
     * @param goodsId    商品ID
     * @param amount     数量
     * @return
     */
    @POST
    @Path("/cart/add")
    public Map<String, Object> addToCart(@HeaderParam("customerId") Long customerId, @FormParam("goodsId") Long goodsId, @FormParam("amount") @DefaultValue("1") Integer amount) {
        if (goodsId == null)
            return SimpleResult.pessimistic(4004, "参数[goodsId]不能为空");
        if (customerId == null)
            return SimpleResult.pessimistic(5000, "系统内部错误，请联系开发者");
        if (amount < 1)
            return SimpleResult.pessimistic(4009, "参数[amount]不正确：amount = {}", amount);
        orderService.addItem(customerId, goodsId, amount);
        return SimpleResult.optimistic();
    }

    /**
     * 减少购物车中某商品的数量
     * 如果数量减少到0则删除购物车项
     * 如果未提交需要减少的数量，则直接删除购物车项
     *
     * @param customerId 顾客ID，由TokenFilter放入请求
     * @param goodsId    商品ID
     * @param amount     需要减少的数量
     * @return
     */
    @POST
    @Path("/cart/drop")
    public Map<String, Object> removeFromCart(@HeaderParam("customerId") Long customerId, @FormParam("goodsId") Long goodsId, @FormParam("amount") Integer amount) {
        if (goodsId == null)
            return SimpleResult.pessimistic(4004, "参数[goodsId]不能为空");
        if (customerId == null)
            return SimpleResult.pessimistic(5000, "系统内部错误，请联系开发者");
        if (amount < 1)
            return SimpleResult.pessimistic(4009, "参数[amount]不正确：amount = {}", amount);
        if (amount == null) {
            orderService.deleteItem(customerId, goodsId);
        } else {
            orderService.dropItemAmount(customerId, goodsId, amount);
        }
        return SimpleResult.optimistic();
    }

    /**
     * 获取顾客在某店铺的购物车信息
     *
     * @param customerId
     * @param shopId
     * @return
     */
    @GET
    @Path("/cart")
    public Map<String, Object> cartInfo(@HeaderParam("customerId") Long customerId, @QueryParam("shopId") Long shopId) {
        if (shopId == null)
            return SimpleResult.pessimistic(4004, "参数[shopId]不能为空");
        if (customerId == null)
            return SimpleResult.pessimistic(5000, "系统内部错误，请联系开发者");
        Map<String, Object> result = SimpleResult.optimistic();
        List<OrderItem> items = orderItemService.findShopUnOrder(customerId, shopId);
        result.put("totalPrice", orderService.getItemsTotalPrice(items));
        result.put("items", OrderItemVo.listFromOrderItems(items));
        return result;
    }

    /**
     * 顾客下单，把顾客在某店铺的未下单商品生成订单
     *
     * @param customerId 顾客ID
     * @param shopId     店铺ID
     * @param couponId   使用的优惠券，空表示未使用优惠券
     * @return
     */
    @POST
    @Path("/generate")
    public Map<String, Object> generate(@HeaderParam("customerId") Long customerId, @FormParam("shopId") Long shopId, @FormParam("couponId") Long couponId) {
        if (shopId == null)
            return SimpleResult.pessimistic(4004, "参数[shopId]不能为空");
        if (customerId == null)
            return SimpleResult.pessimistic(5000, "系统内部错误，请联系开发者");
        Order order = orderService.generateShopOrder(customerId, shopId, couponId);
        if (order == null)
            return SimpleResult.pessimistic(4009, "顾客在该店铺的购物车中没有商品：shopId = {}", shopId);
        Map<String, Object> result = SimpleResult.optimistic();
        result.put("order", OrderVo.fromOrder(order));
        return result;
    }

    /**
     * 获取顾客订单列表，按下单时间降序排列
     *
     * @param customerId 顾客ID
     * @return
     */
    @GET
    @Path("/list")
    public Map<String, Object> list(@HeaderParam("customerId") Long customerId) {
        if (customerId == null)
            return SimpleResult.pessimistic(5000, "系统内部错误，请联系开发者");
        Map<String, Object> result = SimpleResult.optimistic();
        result.put("orders", OrderVo.listFromOrders(orderService.customerList(customerId)));
        return result;
    }

    /**
     * 获取订单详细信息
     *
     * @param orderId
     * @return
     */
    @GET
    @Path("/detail")
    public Map<String, Object> detail(@QueryParam("orderId") Long orderId, @HeaderParam("customerId") Long customerId) {
        if (orderId == null)
            return SimpleResult.pessimistic(4004, "参数[orderId]不能为空");
        Order order = orderService.get(orderId);
        if (!order.getCustomer().getId().equals(customerId))
            return SimpleResult.pessimistic(4009, "订单不属于当前顾客：customerId = {}, orderId = {}", customerId, orderId);
        Map<String, Object> result = SimpleResult.optimistic();
        result.put("order", OrderVo.fromOrder(order));
        result.put("items", OrderItemVo.listFromOrderItems(order.getOrderItems()));
        return result;
    }

    /**
     * 支付订单
     *
     * @param orderId
     * @param customerId
     * @return
     */
    @POST
    @Path("/pay")
    public Map<String, Object> pay(@FormParam("orderId") Long orderId, @HeaderParam("customerId") Long customerId) {
        if (orderId == null)
            return SimpleResult.pessimistic(4004, "参数[orderId]不能为空");
        Order order = orderService.get(orderId);
        if (!order.getCustomer().getId().equals(customerId))
            return SimpleResult.pessimistic(4009, "订单不属于当前顾客：customerId = {}, orderId = {}", customerId, orderId);
        if (!order.getStatus().equals(Character.valueOf('1')))
            return SimpleResult.pessimistic(4010, "订单当前状态无法执行该操作：orderId = {}, status = {}", orderId, order.getStatus());
        orderService.pay(orderId);
        return SimpleResult.optimistic();
    }

    /**
     * 顾客取餐
     *
     * @param orderId
     * @param customerId
     * @return
     */
    @POST
    @Path("/take")
    public Map<String, Object> take(@FormParam("orderId") Long orderId, @HeaderParam("customerId") Long customerId) {
        if (orderId == null)
            return SimpleResult.pessimistic(4004, "参数[orderId]不能为空");
        Order order = orderService.get(orderId);
        if (!order.getCustomer().getId().equals(customerId))
            return SimpleResult.pessimistic(4009, "订单不属于当前顾客：customerId = {}, orderId = {}", customerId, orderId);
        if (!order.getStatus().equals(Character.valueOf('4')))
            return SimpleResult.pessimistic(4010, "订单当前状态无法执行该操作：orderId = {}, status = {}", orderId, order.getStatus());
        orderService.take(orderId);
        return SimpleResult.optimistic();
    }

    /**
     * 顾客取消订单
     *
     * @param orderId
     * @param customerId
     * @return
     */
    @POST
    @Path("/cancel")
    public Map<String, Object> cancel(@FormParam("orderId") Long orderId, @HeaderParam("customerId") Long customerId) {
        if (orderId == null)
            return SimpleResult.pessimistic(4004, "参数[orderId]不能为空");
        Order order = orderService.get(orderId);
        if (!order.getCustomer().getId().equals(customerId))
            return SimpleResult.pessimistic(4009, "订单不属于当前顾客：customerId = {}, orderId = {}", customerId, orderId);
        if (!order.getStatus().equals(Character.valueOf('1')) && !order.getStatus().equals(Character.valueOf('2')))
            return SimpleResult.pessimistic(4010, "订单当前状态无法执行该操作：orderId = {}, status = {}", orderId, order.getStatus());
        orderService.cancel(orderId);
        return SimpleResult.optimistic();
    }

}
