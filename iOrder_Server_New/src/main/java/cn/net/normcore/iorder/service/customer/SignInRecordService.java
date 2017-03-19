package cn.net.normcore.iorder.service.customer;

import cn.net.normcore.iorder.entity.customer.SignInRecord;
import cn.net.normcore.iorder.service.BaseService;

import java.util.List;

/**
 * Created by 81062 on 2017/3/19.
 */
public interface SignInRecordService extends BaseService<SignInRecord, Long> {

    /**
     * 查询当日是否已签到
     *
     * @param customerId 顾客ID
     * @param shopId     店铺ID
     * @return
     */
    boolean isTodaySigned(Long customerId, Long shopId);

    /**
     * 顾客店铺签到
     *
     * @param customerId 顾客ID
     * @param shopId     店铺ID
     */
    void signIn(Long customerId, Long shopId);

    /**
     * 查询顾客在店铺的某月签到记录列表
     *
     * @param customerId 顾客ID
     * @param shopId     店铺ID
     * @param year       年，自然年，2017表示2017年
     * @param month      月，自然月，1表示1月
     * @return
     */
    List<SignInRecord> findRecords(Long customerId, Long shopId, Integer year, Integer month);
}
