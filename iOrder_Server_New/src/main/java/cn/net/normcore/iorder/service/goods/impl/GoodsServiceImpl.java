package cn.net.normcore.iorder.service.goods.impl;

import cn.net.normcore.iorder.entity.goods.Goods;
import cn.net.normcore.iorder.repository.goods.GoodsRepository;
import cn.net.normcore.iorder.service.BaseServiceImpl;
import cn.net.normcore.iorder.service.goods.GoodsService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by 81062 on 2017/3/19.
 */
@Service
@Transactional(readOnly = true)
public class GoodsServiceImpl extends BaseServiceImpl<Goods, Long, GoodsRepository> implements GoodsService {
}
