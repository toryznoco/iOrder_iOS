package cn.net.normcore.iorder.service;

import cn.net.normcore.iorder.entity.BaseEntity;
import cn.net.normcore.iorder.repository.BaseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * Service基类实现
 * Created by 81062 on 2017/3/16.
 */
@Transactional(readOnly = true)
public class BaseServiceImpl<E extends BaseEntity, ID extends Serializable, R extends BaseRepository> implements BaseService<E, ID> {
    @Autowired
    protected R repository;

    @Override
    public E get(ID id) {
        return (E) repository.findOne(id);
    }

    @Transactional
    @Override
    public E save(E e) {
        //新增
        if (e.getId() == null) {
            e.setPath(Character.valueOf('1'));
            e.setCreateTime(new Date());
        }
        //更新
        if (e.getId() != null)
            e.setUpdateTime(new Date());
        return (E) repository.save(e);
    }

    @Transactional
    @Override
    public void recycle(E e) {
        e.setPath(Character.valueOf('0'));
        save(e);
    }

    @Transactional
    @Override
    public void delete(E e) {
        repository.delete(e);
    }

    @Override
    public List<E> findAll() {
        return repository.findByPathNot(Character.valueOf('0'));
    }

    @Transactional
    @Override
    public List<E> saveAll(List<E> list) {
        return repository.save(list);
    }
}
