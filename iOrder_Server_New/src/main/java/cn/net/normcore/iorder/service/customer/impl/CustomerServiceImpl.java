package cn.net.normcore.iorder.service.customer.impl;

import cn.net.normcore.iorder.entity.customer.Customer;
import cn.net.normcore.iorder.entity.customer.MarkedGoods;
import cn.net.normcore.iorder.entity.customer.MarkedShop;
import cn.net.normcore.iorder.repository.customer.CustomerRepository;
import cn.net.normcore.iorder.service.BaseServiceImpl;
import cn.net.normcore.iorder.service.business.ShopService;
import cn.net.normcore.iorder.service.customer.CustomerService;
import cn.net.normcore.iorder.service.customer.MarkedGoodsService;
import cn.net.normcore.iorder.service.customer.MarkedShopService;
import cn.net.normcore.iorder.service.customer.SignInRecordService;
import cn.net.normcore.iorder.service.goods.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 顾客Service实现
 * Created by 81062 on 2017/3/16.
 */
@Service
@Transactional(readOnly = true)
public class CustomerServiceImpl extends BaseServiceImpl<Customer, Long, CustomerRepository> implements CustomerService {
    @Autowired
    private MarkedShopService markedShopService;
    @Autowired
    private ShopService shopService;
    @Autowired
    private MarkedGoodsService markedGoodsService;
    @Autowired
    private GoodsService goodsService;
    @Autowired
    private SignInRecordService signInRecordService;

    @Override
    public Customer findByMobile(String mobile) {
        return repository.findByMobile(mobile);
    }

    @Override
    @Transactional
    public void markShop(Long customerId, Long shopId, String remarks) {
        MarkedShop markedShop = markedShopService.findExists(customerId, shopId);
        if (markedShop == null) {
            markedShop = new MarkedShop();
            markedShop.setCustomer(get(customerId));
            markedShop.setShop(shopService.get(shopId));
        }
        markedShop.setRemarks(remarks);
        markedShopService.save(markedShop);
    }

    @Override
    @Transactional
    public void markGoods(Long customerId, Long goodsId, String remarks) {
        MarkedGoods markedGoods = markedGoodsService.findExists(customerId, goodsId);
        if (markedGoods == null) {
            markedGoods = new MarkedGoods();
            markedGoods.setCustomer(get(customerId));
            markedGoods.setGoods(goodsService.get(goodsId));
        }
        markedGoods.setRemarks(remarks);
        markedGoodsService.save(markedGoods);
    }

    @Override
    @Transactional
    public boolean signIn(Long customerId, Long shopId) {
        if (signInRecordService.isTodaySigned(customerId, shopId))
            return false;
        signInRecordService.signIn(customerId, shopId);
        return true;
    }
}
