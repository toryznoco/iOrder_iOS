package cn.net.normcore.iorder.service.customer.impl;

import cn.net.normcore.iorder.entity.customer.Customer;
import cn.net.normcore.iorder.repository.customer.CustomerRepository;
import cn.net.normcore.iorder.service.BaseServiceImpl;
import cn.net.normcore.iorder.service.customer.CustomerService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 顾客Service实现
 * Created by 81062 on 2017/3/16.
 */
@Service
@Transactional
public class CustomerServiceImpl extends BaseServiceImpl<Customer, Long, CustomerRepository> implements CustomerService {

    @Override
    public Customer findByMobile(String mobile) {
        return repository.findByMobile(mobile);
    }
}
