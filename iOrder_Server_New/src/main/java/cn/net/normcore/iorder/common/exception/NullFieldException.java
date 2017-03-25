package cn.net.normcore.iorder.common.exception;

/**
 * Created by 81062 on 2017/3/24.
 */
public class NullFieldException extends EntityConvertorException {

    public NullFieldException(String entityName, String fieldName) {
        super(entityName, fieldName, "不能为空", null, String.format("%s.%s不能为空", entityName, fieldName));
    }
}
