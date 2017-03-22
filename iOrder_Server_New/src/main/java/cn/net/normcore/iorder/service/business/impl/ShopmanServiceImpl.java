package cn.net.normcore.iorder.service.business.impl;

import cn.net.normcore.iorder.entity.business.Shopman;
import cn.net.normcore.iorder.repository.business.ShopmanRepository;
import cn.net.normcore.iorder.service.BaseServiceImpl;
import cn.net.normcore.iorder.service.business.ShopmanService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by RenQiang on 2017/3/20.
 */
@Service
@Transactional(readOnly = true)
public class ShopmanServiceImpl extends BaseServiceImpl<Shopman, Long, ShopmanRepository> implements ShopmanService {
    @Override
    public Shopman findLogin(String account) {
        return repository.findByMobileOrLoginName(account, account);
    }
}
