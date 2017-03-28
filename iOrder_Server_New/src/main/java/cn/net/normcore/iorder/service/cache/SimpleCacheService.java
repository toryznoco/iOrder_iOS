package cn.net.normcore.iorder.service.cache;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Service;

import java.util.concurrent.TimeUnit;

/**
 * Created by 81062 on 2017/3/28.
 */
@Service
public class SimpleCacheService {
    @Autowired
    private StringRedisTemplate template;

    public void save(String key, String value) {
        ValueOperations<String, String> stringOper = template.opsForValue();
        stringOper.set(key, value);
    }

    public void save(String key, String value, Long ttlSeconds) {
        ValueOperations<String, String> stringOper = template.opsForValue();
        stringOper.set(key, value, ttlSeconds, TimeUnit.SECONDS);
    }

    public String get(String key) {
        ValueOperations<String, String> stringOper = template.opsForValue();
        return stringOper.get(key);
    }

    public void delete(String key) {
        template.delete(key);
    }
}
