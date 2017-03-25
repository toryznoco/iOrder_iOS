package cn.net.normcore.iorder.common.exception;

/**
 * Created by 81062 on 2017/3/24.
 */
public class IdNotFoundException extends EntityConvertorException {

    public IdNotFoundException(String entityName, Long id) {
        super(entityName, "id", "ID不存在", id, String.format("%s.id[%d]不存在", entityName, id));
    }
}
