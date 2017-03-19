package cn.net.normcore.iorder.service.business.impl;

import cn.net.normcore.iorder.entity.business.Coupon;
import cn.net.normcore.iorder.repository.business.CouponRepository;
import cn.net.normcore.iorder.service.BaseServiceImpl;
import cn.net.normcore.iorder.service.business.CouponService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by 81062 on 2017/3/19.
 */
@Service
@Transactional(readOnly = true)
public class CouponServiceImpl extends BaseServiceImpl<Coupon, Long, CouponRepository> implements CouponService {
}
