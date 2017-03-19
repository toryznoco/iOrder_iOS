package cn.net.normcore.iorder.service.business.impl;

import cn.net.normcore.iorder.entity.business.Shop;
import cn.net.normcore.iorder.repository.business.ShopRepository;
import cn.net.normcore.iorder.service.BaseServiceImpl;
import cn.net.normcore.iorder.service.business.ShopService;
import cn.net.normcore.iorder.service.customer.SignInRecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by 81062 on 2017/3/18.
 */
@Service
@Transactional(readOnly = true)
public class ShopServiceImpl extends BaseServiceImpl<Shop, Long, ShopRepository> implements ShopService {
    @Autowired
    private SignInRecordService signInRecordService;

    @Override
    public List<Shop> findNear(double lng, double lat, int pageNum, int pageSize) {
        List<Shop> nearShops = new ArrayList<>();
        List<Object[]> shopMaps = repository.findNear(lng, lat, (pageNum - 1) * pageSize, pageSize);
        shopMaps.forEach(shopProps -> {
            Shop shop = new Shop();
            shop.setId(((BigInteger) shopProps[0]).longValue());
            shop.setCreateTime((Date) shopProps[1]);
            shop.setPath((Character) shopProps[2]);
            shop.setUpdateTime((Date) shopProps[3]);
            shop.setAddress((String) shopProps[4]);
            shop.setCheapInfo((String) shopProps[5]);
            shop.setHeadImage((String) shopProps[6]);
            shop.setName((String) shopProps[7]);
            shop.setPersonalPrice((Float) shopProps[8]);
            shop.setPicture((String) shopProps[9]);
            shop.setTotalSale((Integer) shopProps[10]);
            shop.setxCoord((Double) shopProps[11]);
            shop.setyCoord((Double) shopProps[12]);
            shop.setDetailBackImage((String) shopProps[13]);
            shop.setNotice((String) shopProps[14]);
            shop.setPayOnline((Boolean) shopProps[15]);
            shop.setPhone((String) shopProps[16]);
            shop.setScore((Float) shopProps[17]);
            shop.setCloseTime((Date) shopProps[18]);
            shop.setOpenTime((Date) shopProps[19]);
            shop.setDistance((Integer) shopProps[20]);
            nearShops.add(shop);
        });
        return nearShops;
    }

    @Override
    public Shop customerDetail(Long shopId, Long customerId) {
        Shop shop = get(shopId);
        shop.setTodaySigned(signInRecordService.isTodaySigned(customerId, shopId));
        return shop;
    }
}
