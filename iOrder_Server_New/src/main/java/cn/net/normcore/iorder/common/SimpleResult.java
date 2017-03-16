package cn.net.normcore.iorder.common;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by 81062 on 2017/3/16.
 */
public class SimpleResult {

    public static Map<String, Object> optimistic() {
        return optimistic(null);
    }

    public static Map<String, Object> optimistic(String message) {
        return getSimpleMap("success", "2000", message);
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

    public static Map<String, Object> pessimistic(String code) {
        return pessimistic(code, null);
    }

    public static Map<String, Object> pessimistic(String code, String message) {
        return getSimpleMap("error", code, message);
    }

    public static Map<String, Object> pessimistic(String code, String message, Object... args) {
        if (args != null && args.length > 0) {
            for (Object o :
                    args) {
                message = message.replace("{}", o.toString());
            }
        }
        return pessimistic(code, message);
    }

    private static Map<String, Object> getSimpleMap(String result, String code, String message) {
        Map<String, Object> map = new HashMap<>();
        map.put("result", result);
        map.put("code", code);
        map.put("message", message == null ? "" : message);
        return map;
    }
}
