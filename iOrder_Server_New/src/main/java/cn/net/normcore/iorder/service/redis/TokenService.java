package cn.net.normcore.iorder.service.redis;

import cn.net.normcore.iorder.common.utils.Config;
import cn.net.normcore.iorder.entity.BaseEntity;
import cn.net.normcore.iorder.entity.business.Shopman;
import cn.net.normcore.iorder.entity.customer.Customer;
import cn.net.normcore.iorder.vo.common.Token;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Service;

import java.util.concurrent.TimeUnit;

/**
 * 操作TOKEN存取的服务类
 * Created by RenQiang on 2017/3/17.
 */
@Service
public class TokenService<E extends BaseEntity> {
    @Autowired
    RedisTemplate<String, Token> template;

    /**
     * 查询TOKEN
     *
     * @param key
     * @return
     */
    public Token get(String key) {
        ValueOperations<String, Token> valueOper = template.opsForValue();
        return valueOper.get(key);
    }

    /**
     * 保存TOKEN
     *
     * @param key
     * @param clientId
     * @param user
     */
    public void save(String key, String clientId, E user) {
        Token token = new Token();
        token.setId(user.getId());
        token.setType((user instanceof Customer) ? '1' : (user instanceof Shopman) ? '2' : '0');
        token.setClientId(clientId);
        ValueOperations<String, Token> valueOper = template.opsForValue();
        valueOper.set(key, token, Config.getLong("token_ttl"), TimeUnit.MINUTES);
    }
}
