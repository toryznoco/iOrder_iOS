package cn.net.normcore.iorder.repository.customer;

import cn.net.normcore.iorder.entity.customer.Customer;
import cn.net.normcore.iorder.repository.BaseRepository;

/**
 * 顾客数据库操作类
 * Created by 81062 on 2017/3/16.
 */
public interface CustomerRepository extends BaseRepository<Customer, Long> {
    Customer findByMobile(String mobile);
}
