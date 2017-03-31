package cn.net.normcore.iorder.api.web;

import cn.net.normcore.iorder.common.SimpleResult;
import cn.net.normcore.iorder.filter.ValidateToken;
import cn.net.normcore.iorder.service.order.OrderService;
import cn.net.normcore.iorder.vo.order.OrderVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
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

    @GET
    @Path("/list")
    @ValidateToken
    public Map<String, Object> list(@HeaderParam("shopmanId") Long shopmanId) {
        Map<String, Object> result = SimpleResult.optimistic();
        result.put("orders", OrderVo.listFromOrders(orderService.findShopAll(shopmanId)));
        return result;
    }
}
