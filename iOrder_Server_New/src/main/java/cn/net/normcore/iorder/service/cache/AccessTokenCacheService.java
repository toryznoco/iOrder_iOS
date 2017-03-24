package cn.net.normcore.iorder.service.cache;

import cn.net.normcore.iorder.common.utils.Config;
import cn.net.normcore.iorder.vo.token.AccessToken;
import cn.net.normcore.iorder.vo.token.RefreshToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Service;

import java.util.concurrent.TimeUnit;

/**
 * Created by 81062 on 2017/3/23.
 */
@Service
public class AccessTokenCacheService {
    @Autowired
    private RedisTemplate<String, AccessToken> template;

    public void save(String key, AccessToken accessToken) {
        ValueOperations<String, AccessToken> accessTokenOper = template.opsForValue();
        accessTokenOper.set(key, accessToken, Config.getLong("access_token_ttl"), TimeUnit.SECONDS);
    }

    public AccessToken get(String key) {
        ValueOperations<String, AccessToken> accessTokenOper = template.opsForValue();
        return accessTokenOper.get(key);
    }

    public long getTTL(String key) {
        return template.getExpire(key);
    }
}
