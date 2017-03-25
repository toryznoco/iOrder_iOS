package cn.net.normcore.iorder.common.exception;

/**
 * 从前台提交的json数据生成实体对象时抛出的异常
 * Created by 81062 on 2017/3/24.
 */
public class EntityConvertorException extends Exception {
    private String entityName;  //实体名称
    private String fieldName;  //属性/参数/字段名称
    private String reason;  //错误原因
    private Object value;  //字段值

    public EntityConvertorException(String entityName, String fieldName, String reason, Object value, String message) {
        super(message);
        this.entityName = entityName;
        this.fieldName = fieldName;
        this.reason = reason;
        this.value = value;
    }
}
