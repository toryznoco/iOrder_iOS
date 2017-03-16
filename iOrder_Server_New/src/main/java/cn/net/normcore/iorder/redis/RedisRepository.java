package cn.net.normcore.iorder.redis;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Repository;

import java.io.Serializable;
import java.util.concurrent.TimeUnit;

/**
 * redis数据库操作类
 *
 * @param <V> value数据类型
 */
@Repository
public class RedisRepository<V extends Serializable> {
    @Autowired
    @Qualifier("redisTemplate")
    RedisTemplate<String, V> template;

    public void save(String key, V value) {
        ValueOperations<String, V> valueOper = template.opsForValue();
        valueOper.set(key, value);
    }

    /**
     * 保存一个键值对并设置生存时间
     *
     * @param key        键
     * @param value      值
     * @param timeToLive 生存时间
     */
    public void save(String key, V value, Long timeToLive) {
        ValueOperations<String, V> valueOper = template.opsForValue();
        valueOper.set(key, value, timeToLive, TimeUnit.MILLISECONDS);
    }

    /**
     * 读取一个键的值
     *
     * @param key 键
     * @return
     */
    public V read(String key) {
        ValueOperations<String, V> valueOper = template.opsForValue();
        return valueOper.get(key);
    }

    /**
     * 删除一个键值对
     *
     * @param key 键
     */
    public void delete(String key) {
        ValueOperations<String, V> valueOper = template.opsForValue();
        valueOper.getOperations().delete(key);
    }
}
