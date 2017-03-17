package cn.net.normcore.iorder.service.redis;

import cn.net.normcore.iorder.common.utils.Config;
import cn.net.normcore.iorder.vo.common.Client;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Service;

import java.util.concurrent.TimeUnit;

/**
 * 操作客户端信息存取的服务类
 * Created by RenQiang on 2017/3/17.
 */
@Service
public class ClientService {
    @Autowired
    private StringRedisTemplate template;

    /**
     * 保存客户端标识信息
     *
     * @param client
     */
    public void saveClientId(Client client) {
        ValueOperations<String, String> valueOper = template.opsForValue();
        valueOper.set(client.getRedisKey(), client.getClientId(), Config.getLong("token_ip_time_interval"), TimeUnit.MINUTES);
    }

    /**
     * 查询客户端标识信息
     *
     * @param client
     * @return
     */
    public String getClientId(Client client) {
        ValueOperations<String, String> valueOper = template.opsForValue();
        return valueOper.get(client.getRedisKey());
    }
}
