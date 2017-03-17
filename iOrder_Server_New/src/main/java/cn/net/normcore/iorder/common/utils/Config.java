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
    private static final Logger LOGGER = LoggerFactory.getLogger(Config.class);
    private static final Properties PROPERTIES = new Properties();

    static {
        try {
            PROPERTIES.load(Config.class.getResourceAsStream("/config/app.properties"));
        } catch (IOException e) {
            e.printStackTrace();
            LOGGER.error("配置文件加载失败！");
        }
    }

    public static long getLong(String key) {
        String stringValue = getProperty(key);
        try {
            return Long.parseLong(stringValue);
        } catch (NumberFormatException e) {
            LOGGER.error("属性值转换错误：[{}] TO Long", stringValue);
            return 0;
        }
    }

    public static String getProperty(String key) {
        String value = PROPERTIES.getProperty(key, "Undefined");
        if (value.equals("Undefined"))
            LOGGER.warn("配置项【{}】未设置！", key);
        return value;
    }
}
