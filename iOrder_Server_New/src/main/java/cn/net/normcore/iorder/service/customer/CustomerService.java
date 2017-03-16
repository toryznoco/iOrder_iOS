package cn.net.normcore.iorder.service.customer;

import cn.net.normcore.iorder.entity.customer.Customer;
import cn.net.normcore.iorder.service.BaseService;

/**
 * 顾客Service接口
 * Created by 81062 on 2017/3/16.
 */
public interface CustomerService extends BaseService<Customer, Long> {

    Customer findByMobile(String mobile);
}
