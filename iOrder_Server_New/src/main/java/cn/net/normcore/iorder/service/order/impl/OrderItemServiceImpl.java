package cn.net.normcore.iorder.service.order.impl;

import cn.net.normcore.iorder.entity.order.OrderItem;
import cn.net.normcore.iorder.repository.order.OrderItemRepository;
import cn.net.normcore.iorder.service.BaseServiceImpl;
import cn.net.normcore.iorder.service.order.OrderItemService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by 81062 on 2017/3/19.
 */
@Service
@Transactional(readOnly = true)
public class OrderItemServiceImpl extends BaseServiceImpl<OrderItem, Long, OrderItemRepository> implements OrderItemService {
    @Override
    public OrderItem findExists(Long customerId, Long goodsId) {
        return repository.findByCustomerIdAndGoodsIdAndOrderIsNull(customerId, goodsId);
    }

    @Override
    public List<OrderItem> findShopUnOrder(Long customerId, Long shopId) {
        return repository.findByCustomerIdAndShopIdAndOrderIsNull(customerId, shopId);
    }
}
