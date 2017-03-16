package cn.net.normcore.iorder.redis;

import cn.net.normcore.iorder.common.utils.Config;
import cn.net.normcore.iorder.entity.BaseEntity;
import cn.net.normcore.iorder.entity.business.Shopman;
import cn.net.normcore.iorder.entity.customer.Customer;
import cn.net.normcore.iorder.vo.common.TokenVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 操作TOKEN存取的服务类
 *
 * @param <E> 用户类型
 */
@Service
public class TokenService<E extends BaseEntity> {
    @Autowired
    private RedisRepository<TokenVo> repository;

    public TokenVo get(String key) {
        return repository.read(key);
    }

    public void save(String key, String ip, E user) {
        TokenVo tokenVo = new TokenVo();
        tokenVo.setId(user.getId());
        tokenVo.setIp(ip);
        tokenVo.setType((user instanceof Customer) ? '1' : (user instanceof Shopman) ? '2' : '0');
        repository.save(key, tokenVo, Long.parseLong(Config.getProperty("token_ttl")));
    }
}
