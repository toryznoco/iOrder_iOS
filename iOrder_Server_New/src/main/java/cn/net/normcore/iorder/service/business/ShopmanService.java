package cn.net.normcore.iorder.service.business;

import cn.net.normcore.iorder.entity.business.Shopman;
import cn.net.normcore.iorder.service.BaseService;

/**
 * Created by RenQiang on 2017/3/20.
 */
public interface ShopmanService extends BaseService<Shopman, Long> {

    /**
     * 登录时查找店主帐号，可以使用手机号和登录名进行登录
     *
     * @param account 登录帐号，可以是手机号码或登录名
     * @return
     */
    Shopman findLogin(String account);
}
