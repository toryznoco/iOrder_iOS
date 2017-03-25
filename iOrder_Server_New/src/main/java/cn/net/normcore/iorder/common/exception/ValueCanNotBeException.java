package cn.net.normcore.iorder.common.exception;

/**
 * Created by 81062 on 2017/3/24.
 */
public class ValueCanNotBeException extends EntityConvertorException {

    public ValueCanNotBeException(String entityName, String fieldName, Object value) {
        super(entityName, fieldName, "字段值不正确", value, String.format("%s.%s不能等于%s", entityName, fieldName, value));
    }
}
