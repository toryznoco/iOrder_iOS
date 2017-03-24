package cn.net.normcore.iorder.common;

import java.util.HashMap;
import java.util.Map;

/**
 * 通用请求响应结果
 * 每个请求结果都包含result、code、message三个字段
 * result表示请求结果，当结果为正常业务期望返回值时，result=success，否则result=error
 * code表示结果码，当结果为正常业务期望返回值时，code=2000，否则code为错误码
 * message是对请求结果的简单描述，可能为空
 * Created by RenQiang on 2017/2/3.
 */
public class SimpleResult {

    public static Map<String, Object> optimistic() {
        return optimistic(null);
    }

    public static Map<String, Object> optimistic(String message) {
        return getSimpleMap(true, 2000, message);
    }

    public static Map<String, Object> optimistic(String message, Object... args) {
        if (args != null && args.length > 0) {
            for (Object o :
                    args) {
                message = message.replace("{}", o.toString());
            }
        }
        return optimistic(message);
    }

    public static Map<String, Object> pessimistic(int code) {
        return pessimistic(code, null);
    }

    public static Map<String, Object> pessimistic(int code, String message) {
        return getSimpleMap(false, code, message);
    }

    public static Map<String, Object> pessimistic(int code, String message, Object... args) {
        if (args != null && args.length > 0) {
            for (Object o :
                    args) {
                message = message.replace("{}", o.toString());
            }
        }
        return pessimistic(code, message);
    }

    private static Map<String, Object> getSimpleMap(boolean result, int code, String message) {
        Map<String, Object> map = new HashMap<>();
        map.put("result", result);
        map.put("code", code);
        map.put("message", message == null ? "" : message);
        return map;
    }
}
