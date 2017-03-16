package cn.net.normcore.iorder.service;

import cn.net.normcore.iorder.entity.BaseEntity;

import java.io.Serializable;
import java.util.List;

/**
 * Service基类接口，提供基本的增、删、查、改操作
 * Created by 81062 on 2017/3/16.
 */
public interface BaseService<E extends BaseEntity, ID extends Serializable> {

    /**
     * 根据ID查询一个对象，ID不存在时返回null
     *
     * @param id
     * @return
     */
    E get(ID id);

    /**
     * 持久化一个对象
     *
     * @return
     */
    E save(E e);

    /**
     * 删除一个持久化对象，把path值设置成0，可恢复
     */
    void recycle(E e);

    /**
     * 删除一个持久化对象，删除数据，不可恢复
     *
     * @param e
     */
    void delete(E e);

    /**
     * 获取所有有效数据，path不为0的数据
     *
     * @return
     */
    List<E> findAll();

    /**
     * 持久化所有实体对象
     *
     * @param list
     * @return
     */
    List<E> saveAll(List<E> list);
}
