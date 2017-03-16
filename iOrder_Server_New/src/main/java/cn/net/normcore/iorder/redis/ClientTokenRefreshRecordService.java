package cn.net.normcore.iorder.redis;

import cn.net.normcore.iorder.common.utils.Config;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 本类用于在缓存中记录同一客户端（同一IP）短时间内是否刷新过TOKEN
 * 目的是防止恶意刷TOKEN（短时间内不断刷新TOKEN）导致缓存中同一用户TOKEN个数过多
 * Created by 81062 on 2017/3/17.
 */
@Service
public class ClientTokenRefreshRecordService {
    @Autowired
    private RedisRepository<String> repository;

    public void save(String ip) {
        repository.save(ip, "1", Long.parseLong(Config.getProperty("token_ip_time_interval")));
    }

    public String get(String ip) {
        return repository.read(ip);
    }
}
