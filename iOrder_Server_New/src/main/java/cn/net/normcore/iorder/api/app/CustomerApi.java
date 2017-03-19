package cn.net.normcore.iorder.api.app;

import cn.net.normcore.iorder.common.SimpleResult;
import cn.net.normcore.iorder.service.customer.CustomerService;
import cn.net.normcore.iorder.service.customer.SignInRecordService;
import cn.net.normcore.iorder.vo.customer.SignInRecordVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;

/**
 * 顾客相关接口
 * Created by 81062 on 2017/3/16.
 */
@Controller
@Path("/app/customer")
@Produces(MediaType.APPLICATION_JSON)
public class CustomerApi {
    @Autowired
    private CustomerService customerService;
    @Autowired
    private SignInRecordService signInRecordService;

    /**
     * 顾客用户收藏店铺
     *
     * @param shopId     店铺ID
     * @param remarks    备注
     * @param customerId 顾客用户ID，由TokenFilter放入请求
     * @return
     */
    @POST
    @Path("/mark/shop")
    public Map<String, Object> markShop(@FormParam("shopId") Long shopId, @FormParam("remarks") String remarks, @QueryParam("customerId") Long customerId) {
        if (shopId == null)
            return SimpleResult.pessimistic("4004", "参数[shopId]不能为空");
        if (customerId == null)
            return SimpleResult.pessimistic("5000", "系统内部错误，请联系开发者");
        customerService.markShop(customerId, shopId, remarks);
        return SimpleResult.optimistic();
    }

    /**
     * 顾客用户收藏商品
     *
     * @param goodsId    商品ID
     * @param remarks    备注
     * @param customerId 顾客ID，由TokenFilter放入请求
     * @return
     */
    @POST
    @Path("/mark/goods")
    public Map<String, Object> markGoods(@FormParam("goodsId") Long goodsId, @FormParam("remarks") String remarks, @QueryParam("customerId") Long customerId) {
        if (goodsId == null)
            return SimpleResult.pessimistic("4004", "参数[goodsId]不能为空");
        if (customerId == null)
            return SimpleResult.pessimistic("5000", "系统内部错误，请联系开发者");
        customerService.markGoods(customerId, goodsId, remarks);
        return SimpleResult.optimistic();
    }

    /**
     * 顾客用户店铺签到
     *
     * @param shopId
     * @param customerId
     * @return
     */
    @POST
    @Path("/signIn")
    public Map<String, Object> signIn(@FormParam("shopId") Long shopId, @QueryParam("customerId") Long customerId) {
        if (shopId == null)
            return SimpleResult.pessimistic("4004", "参数[shopId]不能为空");
        if (customerId == null)
            return SimpleResult.pessimistic("5000", "系统内部错误，请联系开发者");
        if (customerService.signIn(customerId, shopId))
            return SimpleResult.optimistic();
        return SimpleResult.pessimistic("4008", "不能重复签到");
    }

    /**
     * 查询顾客某店铺某月签到记录
     *
     * @param shopId     店铺ID
     * @param customerId 顾客ID
     * @param year       年份，自然年，2017表示2017年，默认值当前年份
     * @param month      月份，自然月，1表示1月，默认值当前月份
     * @return
     */
    @GET
    @Path("/signInRecords")
    public Map<String, Object> signInRecords(@QueryParam("shopId") Long shopId, @QueryParam("customerId") Long customerId, @QueryParam("year") Integer year, @QueryParam("month") Integer month) {
        if (shopId == null)
            return SimpleResult.pessimistic("4004", "参数[shopId]不能为空");
        if (customerId == null)
            return SimpleResult.pessimistic("5000", "系统内部错误，请联系开发者");
        if (year == null)
            year = Calendar.getInstance().get(Calendar.YEAR);
        if (month == null)
            month = Calendar.getInstance().get(Calendar.MONTH) + 1;
        Map<String, Object> result = SimpleResult.optimistic();
        result.put("signInRecords", SignInRecordVo.listFromSignInRecords(signInRecordService.findRecords(customerId, shopId, year, month)));
        return result;
    }
}
