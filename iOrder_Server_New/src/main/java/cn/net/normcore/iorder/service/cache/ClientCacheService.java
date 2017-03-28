package cn.net.normcore.iorder.service.cache;

import cn.net.normcore.iorder.vo.token.Client;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Service;

/**
 * Created by 81062 on 2017/3/23.
 */
@Service
public class ClientCacheService {
    @Autowired
    private RedisTemplate<String, Client> template;
    @Autowired
    private RefreshTokenCacheService refreshTokenCacheService;

    public void save(String key, Client client) {
        ValueOperations<String, Client> clientOper = template.opsForValue();
        clientOper.set(key, client);
    }

    public Client get(String key) {
        ValueOperations<String, Client> clientOper = template.opsForValue();
        return clientOper.get(key);
    }

    public void delete(String key) {
        refreshTokenCacheService.delete(get(key).getRefreshToken());
        template.delete(key);
    }
}
