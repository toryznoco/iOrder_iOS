package cn.net.normcore.iorder.service.customer;

import cn.net.normcore.iorder.entity.customer.Customer;
import cn.net.normcore.iorder.service.BaseService;

/**
 * 顾客Service接口
 * Created by 81062 on 2017/3/16.
 */
public interface CustomerService extends BaseService<Customer, Long> {

    /**
     * 根据手机号码查找
     *
     * @param mobile 手机号码
     * @return
     */
    Customer findByMobile(String mobile);

    /**
     * 顾客用户收藏店铺
     * 如果已存在店铺的收藏记录则更新备注
     *
     * @param customerId 顾客用户ID
     * @param shopId     收藏的店铺ID
     * @param remarks    备注信息
     */
    void markShop(Long customerId, Long shopId, String remarks);

    /**
     * 顾客用户收藏商品
     * 如果已存在商品的收藏记录则更新备注
     *
     * @param customerId 顾客用户ID
     * @param goodsId    收藏的商品ID
     * @param remarks    备注信息
     */
    void markGoods(Long customerId, Long goodsId, String remarks);

    /**
     * 顾客用户店铺签到
     *
     * @param customerId 顾客ID
     * @param shopId     店铺ID
     * @return 正常签到返回true，重复签到返回false
     */
    boolean signIn(Long customerId, Long shopId);
}
