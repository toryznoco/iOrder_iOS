package cn.net.normcore.iorder.repository.business;

import cn.net.normcore.iorder.entity.business.Shopman;
import cn.net.normcore.iorder.repository.BaseRepository;

/**
 * Created by RenQiang on 2017/3/20.
 */
public interface ShopmanRepository extends BaseRepository<Shopman, Long> {

    /**
     * 根据手机号码或者登录名查找
     *
     * @param mobile    手机号码
     * @param loginName 登录名
     * @return
     */
    Shopman findByMobileOrLoginName(String mobile, String loginName);
}
