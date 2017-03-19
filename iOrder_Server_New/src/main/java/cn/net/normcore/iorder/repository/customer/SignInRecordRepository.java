package cn.net.normcore.iorder.repository.customer;

import cn.net.normcore.iorder.entity.customer.SignInRecord;
import cn.net.normcore.iorder.repository.BaseRepository;

import java.util.Date;
import java.util.List;

/**
 * Created by 81062 on 2017/3/19.
 */
public interface SignInRecordRepository extends BaseRepository<SignInRecord, Long> {

    /**
     * 根据顾客ID、店铺ID、签到日期查询
     *
     * @param customerId
     * @param shopId
     * @param signIdDate
     * @return
     */
    SignInRecord findByCustomerIdAndShopIdAndSignInDate(Long customerId, Long shopId, Date signIdDate);

    /**
     * 根据顾客ID、店铺ID、签到起始日期查询
     *
     * @param customerId 顾客ID
     * @param shopId     店铺ID
     * @param beginDate  起始日期
     * @param endDate    截止日期
     * @return
     */
    List<SignInRecord> findByCustomerIdAndShopIdAndSignInDateBetweenOrderBySignInDate(Long customerId, Long shopId, Date beginDate, Date endDate);
}
