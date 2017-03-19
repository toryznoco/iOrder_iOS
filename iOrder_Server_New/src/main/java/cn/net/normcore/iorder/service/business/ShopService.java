package cn.net.normcore.iorder.service.business;

import cn.net.normcore.iorder.entity.business.Shop;
import cn.net.normcore.iorder.service.BaseService;

import java.util.List;

/**
 * Created by 81062 on 2017/3/18.
 */
public interface ShopService extends BaseService<Shop, Long> {

    /**
     * 查询附近的店铺列表
     *
     * @param lng      定位经度
     * @param lat      定位纬度
     * @param pageNum  页号
     * @param pageSize 分页大小,每页数量
     * @return
     */
    List<Shop> findNear(double lng, double lat, int pageNum, int pageSize);

    /**
     * 顾客获取店铺详细信息，店铺对不同顾客信息可能不同，如今日是否签到
     *
     * @param shopId     店铺ID
     * @param customerId 顾客ID
     * @return
     */
    Shop customerDetail(Long shopId, Long customerId);
}
