package cn.net.normcore.iorder.api.app;

import cn.net.normcore.iorder.common.SimpleResult;
import cn.net.normcore.iorder.entity.business.Shop;
import cn.net.normcore.iorder.filter.ValidateToken;
import cn.net.normcore.iorder.service.business.ShopService;
import cn.net.normcore.iorder.vo.business.ShopVo;
import cn.net.normcore.iorder.vo.goods.GoodsCategoryVo;
import cn.net.normcore.iorder.vo.goods.GoodsVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.List;
import java.util.Map;

/**
 * 店铺相关接口
 * Created by 81062 on 2017/3/18.
 */
@Controller
@Path("/app/shop")
@Produces(MediaType.APPLICATION_JSON)
@ValidateToken
public class ShopApi {
    @Autowired
    private ShopService shopService;

    /**
     * 分页获取附近店铺列表
     *
     * @param lng      定位经度
     * @param lat      定位纬度
     * @param pageNum  页号，1表示第1页，默认值1
     * @param pageSize 分页大小，默认值10
     * @return
     */
    @GET
    @Path("/near")
    public Map<String, Object> near(@QueryParam("lng") Double lng, @QueryParam("lat") Double lat, @QueryParam("pageNum") @DefaultValue("1") Integer pageNum, @QueryParam("pageSize") @DefaultValue("10") Integer pageSize) {
        if (lng == null)
            return SimpleResult.pessimistic("4004", "参数[lng]不能为空");
        if (lat == null)
            return SimpleResult.pessimistic("4004", "参数[lat]不能为空");
        List<Shop> nearShops = shopService.findNear(lng, lat, pageNum, pageSize);
        Map<String, Object> result = SimpleResult.optimistic();
        result.put("nearShops", ShopVo.listFromShops(nearShops));
        return result;
    }

    /**
     * 获取店铺分类商品列表
     *
     * @param shopId 店铺ID
     * @return
     */
    @GET
    @Path("/goods")
    public Map<String, Object> goods(@QueryParam("shopId") Long shopId) {
        if (shopId == null)
            return SimpleResult.pessimistic("4004", "参数[shopId]不能为空");
        Shop shop = shopService.get(shopId);
        Map<String, Object> result = SimpleResult.optimistic();
        result.put("categories", GoodsCategoryVo.listFromCategories(shop.getGoodsCategories()));
        result.put("goods", GoodsVo.listFromGoods(shop.noCategoryGoods()));
        return result;
    }

    /**
     * 获取店铺详细信息
     *
     * @param shopId     店铺ID
     * @param customerId 顾客ID，用于判断顾客今日是否已签到
     * @return
     */
    @GET
    @Path("/detail")
    public Map<String, Object> detail(@QueryParam("shopId") Long shopId, @HeaderParam("customerId") Long customerId) {
        if (shopId == null)
            return SimpleResult.pessimistic("4004", "参数[shopId]不能为空");
        Map<String, Object> result = SimpleResult.optimistic();
        result.put("shopDetail", ShopVo.fromShop(shopService.customerDetail(shopId, customerId)));
        return result;
    }
}
