package cn.net.normcore.iorder.service.customer.impl;

import cn.net.normcore.iorder.entity.customer.MarkedShop;
import cn.net.normcore.iorder.repository.customer.MarkedShopRepository;
import cn.net.normcore.iorder.service.BaseServiceImpl;
import cn.net.normcore.iorder.service.customer.MarkedShopService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by 81062 on 2017/3/19.
 */
@Service
@Transactional(readOnly = true)
public class MarkedShopServiceImpl extends BaseServiceImpl<MarkedShop, Long, MarkedShopRepository> implements MarkedShopService {
    @Override
    public MarkedShop findExists(Long customerId, Long shopId) {
        return repository.findByCustomerIdAndShopId(customerId, shopId);
    }
}
