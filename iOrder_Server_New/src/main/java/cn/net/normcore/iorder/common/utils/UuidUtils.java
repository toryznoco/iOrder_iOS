package cn.net.normcore.iorder.common.utils;

import java.util.UUID;

/**
 * UUID工具类
 * Created by 81062 on 2017/3/16.
 */
public class UuidUtils {

    /**
     * 生成32位唯一UUID
     *
     * @return
     */
    public static String simpleUuid() {
        String uuid = UUID.randomUUID().toString();
        return uuid.replaceAll("-", "");
    }
}
