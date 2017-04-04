package cn.net.normcore.iorder.api.web;

import cn.net.normcore.iorder.common.SimpleResult;
import cn.net.normcore.iorder.entity.order.Order;
import cn.net.normcore.iorder.filter.ValidateToken;
import cn.net.normcore.iorder.service.order.OrderService;
import cn.net.normcore.iorder.vo.order.OrderVo;
import com.fasterxml.jackson.databind.JsonNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import javax.validation.constraints.NotNull;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.List;
import java.util.Map;

/**
 * Created by RenQiang on 2017/3/31.
 */
@Controller("webOrderApi")
@Path("/web/order")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class OrderApi {
    @Autowired
    private OrderService orderService;

    /**
     * 商家订单列表
     *
     * @param shopmanId
     * @return
     */
    @GET
    @Path("/list")
    @ValidateToken
    public List<OrderVo> list(@HeaderParam("shopmanId") @NotNull Long shopmanId) {
        return OrderVo.listFromOrders(orderService.findShopAll(shopmanId));
    }

    /**
     * 商家接单
     *
     * @param data
     * @param shopmanId
     * @return
     */
    @POST
    @Path("/receive")
    @ValidateToken
    public Map<String, Object> receive(JsonNode data, @HeaderParam("shopmanId") @NotNull Long shopmanId) {
        Long orderId = data.get("orderId").asLong();
        Order order = orderService.get(orderId);
        if (!order.getShop().getShopman().getId().equals(shopmanId))
            return SimpleResult.pessimistic(4009, "订单不属于当前店铺：shopmanId = {}, orderId = {}", shopmanId, orderId);
        if (!order.getStatus().equals(Character.valueOf('2')))
            return SimpleResult.pessimistic(4010, "订单当前状态无法执行该操作：orderId = {}, status = {}", orderId, order.getStatus());
        orderService.receive(orderId);
        return SimpleResult.optimistic();
    }

    /**
     * 订单商品制作完成，通知取餐
     *
     * @param data
     * @param shopmanId
     * @return
     */
    @POST
    @Path("/complete")
    @ValidateToken
    public Map<String, Object> complete(JsonNode data, @HeaderParam("shopmanId") @NotNull Long shopmanId) {
        Long orderId = data.get("orderId").asLong();
        Order order = orderService.get(orderId);
        if (!order.getShop().getShopman().getId().equals(shopmanId))
            return SimpleResult.pessimistic(4009, "订单不属于当前店铺：shopmanId = {}, orderId = {}", shopmanId, orderId);
        if (!order.getStatus().equals(Character.valueOf('3')))
            return SimpleResult.pessimistic(4010, "订单当前状态无法执行该操作：orderId = {}, status = {}", orderId, order.getStatus());
        orderService.complete(orderId);
        return SimpleResult.optimistic();
    }

    /**
     * 商家取消订单
     *
     * @param data
     * @param shopmanId
     * @return
     */
    @POST
    @Path("/cancel")
    @ValidateToken
    public Map<String, Object> cancel(JsonNode data, @HeaderParam("shopmanId") @NotNull Long shopmanId) {
        Long orderId = data.get("orderId").asLong();
        Order order = orderService.get(orderId);
        if (!order.getShop().getShopman().getId().equals(shopmanId))
            return SimpleResult.pessimistic(4009, "订单不属于当前店铺：shopmanId = {}, orderId = {}", shopmanId, orderId);
        if (!order.getStatus().equals(Character.valueOf('1')) && !order.getStatus().equals(Character.valueOf('2')) && !order.getStatus().equals(Character.valueOf('3')))
            return SimpleResult.pessimistic(4010, "订单当前状态无法执行该操作：orderId = {}, status = {}", orderId, order.getStatus());
        orderService.cancel(orderId);
        return SimpleResult.optimistic();
    }

}
