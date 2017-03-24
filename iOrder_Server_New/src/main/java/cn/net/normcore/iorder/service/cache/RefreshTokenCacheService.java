package cn.net.normcore.iorder.service.cache;

import cn.net.normcore.iorder.common.utils.Config;
import cn.net.normcore.iorder.vo.token.Client;
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
public class RefreshTokenCacheService {
    @Autowired
    private RedisTemplate<String, RefreshToken> template;

    public void save(String key, RefreshToken refreshToken) {
        ValueOperations<String, RefreshToken> refreshTokenOper = template.opsForValue();
        refreshTokenOper.set(key, refreshToken, Config.getLong("refresh_token_ttl"), TimeUnit.SECONDS);
    }

    public RefreshToken get(String key) {
        ValueOperations<String, RefreshToken> refreshTokenOper = template.opsForValue();
        return refreshTokenOper.get(key);
    }

    public void delete(String key) {
        template.delete(get(key).getAccessToken());
        template.delete(key);
    }
}
