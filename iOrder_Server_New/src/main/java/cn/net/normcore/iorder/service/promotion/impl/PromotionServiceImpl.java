package cn.net.normcore.iorder.service.promotion.impl;

import cn.net.normcore.iorder.entity.promotion.Promotion;
import cn.net.normcore.iorder.repository.promotion.PromotionRepository;
import cn.net.normcore.iorder.service.BaseServiceImpl;
import cn.net.normcore.iorder.service.promotion.PromotionService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by 81062 on 2017/3/19.
 */
@Service
@Transactional(readOnly = true)
public class PromotionServiceImpl extends BaseServiceImpl<Promotion, Long, PromotionRepository> implements PromotionService {
}
