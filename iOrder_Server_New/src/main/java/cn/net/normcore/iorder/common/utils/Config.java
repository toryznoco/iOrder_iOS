package cn.net.normcore.iorder.common.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.Properties;

/**
 * 读取配置文件工具类
 * Created by 81062 on 2017/3/16.
 */
public class Config {
    private static final Logger logger = LoggerFactory.getLogger(Config.class);
    private static final Properties PROPERTIES = new Properties();

    static {
        try {
            PROPERTIES.load(Config.class.getResourceAsStream("/config/app.properties"));
        } catch (IOException e) {
            e.printStackTrace();
            logger.error("配置文件加载失败！");
        }
    }

    public static String getProperty(String key) {
        String value = PROPERTIES.getProperty(key, "Undefined");
        if (value.equals("Undefined"))
            logger.warn("配置项【{}】未设置！", key);
        return value;
    }
}
