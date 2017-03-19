package cn.net.normcore.iorder.service.customer.impl;

import cn.net.normcore.iorder.entity.customer.SignInRecord;
import cn.net.normcore.iorder.repository.customer.SignInRecordRepository;
import cn.net.normcore.iorder.service.BaseServiceImpl;
import cn.net.normcore.iorder.service.business.ShopService;
import cn.net.normcore.iorder.service.customer.CustomerService;
import cn.net.normcore.iorder.service.customer.SignInRecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Created by 81062 on 2017/3/19.
 */
@Service
@Transactional(readOnly = true)
public class SignInRecordServiceImpl extends BaseServiceImpl<SignInRecord, Long, SignInRecordRepository> implements SignInRecordService {
    @Autowired
    private ShopService shopService;
    @Autowired
    private CustomerService customerService;

    @Override
    public boolean isTodaySigned(Long customerId, Long shopId) {
        return repository.findByCustomerIdAndShopIdAndSignInDate(customerId, shopId, new Date()) != null;
    }

    @Override
    @Transactional
    public void signIn(Long customerId, Long shopId) {
        SignInRecord signInRecord = new SignInRecord();
        signInRecord.setCustomer(customerService.get(customerId));
        signInRecord.setShop(shopService.get(shopId));
        signInRecord.setSignInDate(new Date());
        signInRecord.setSignInTime(new Date());
        save(signInRecord);
    }

    @Override
    public List<SignInRecord> findRecords(Long customerId, Long shopId, Integer year, Integer month) {
        Calendar c = Calendar.getInstance();
        c.set(Calendar.YEAR, year);
        c.set(Calendar.MONTH, month - 1);
        c.set(Calendar.DAY_OF_MONTH, 1);
        Date monthFirstDay = c.getTime();
        c.add(Calendar.MONTH, 1);
        c.set(Calendar.DAY_OF_MONTH, 0);
        Date monthLastDay = c.getTime();
        return repository.findByCustomerIdAndShopIdAndSignInDateBetweenOrderBySignInDate(customerId, shopId, monthFirstDay, monthLastDay);
    }
}
