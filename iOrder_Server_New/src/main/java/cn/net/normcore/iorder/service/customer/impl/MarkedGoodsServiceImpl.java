package cn.net.normcore.iorder.service.customer.impl;

import cn.net.normcore.iorder.entity.customer.MarkedGoods;
import cn.net.normcore.iorder.repository.customer.MarkedGoodsRepository;
import cn.net.normcore.iorder.service.BaseServiceImpl;
import cn.net.normcore.iorder.service.customer.MarkedGoodsService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by 81062 on 2017/3/19.
 */
@Service
@Transactional(readOnly = true)
public class MarkedGoodsServiceImpl extends BaseServiceImpl<MarkedGoods, Long, MarkedGoodsRepository> implements MarkedGoodsService {
    @Override
    public MarkedGoods findExists(Long customerId, Long goodsId) {
        return repository.findByCustomerIdAndGoodsId(customerId, goodsId);
    }
}
