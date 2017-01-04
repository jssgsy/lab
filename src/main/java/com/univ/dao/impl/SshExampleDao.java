package com.univ.dao.impl;

import com.univ.dao.ISshExampleDao;
import com.univ.entity.SshExampleEntity;
import org.springframework.stereotype.Repository;

import java.io.Serializable;
import java.util.List;

/**
 * created by Univ
 * 16/5/19 16:44
 */

@Repository
public class SshExampleDao extends AbstractBaseDao implements ISshExampleDao {

    public Serializable save(SshExampleEntity entity) {
        return getCurrentSession().save(entity);
    }

    public void delete(SshExampleEntity entity) {
        getCurrentSession().delete(entity);
    }

    public void update(Object entity) {
        getCurrentSession().update(entity);
    }

    public SshExampleEntity get(Class entityClass, Serializable id) {
        return (SshExampleEntity) getCurrentSession().get(entityClass, id);
    }

    public SshExampleEntity load(Class entityClass, Serializable id) {
        return (SshExampleEntity) getCurrentSession().load(entityClass, id);
    }

    public List<SshExampleEntity> getAll() {
        return getCurrentSession().createQuery("from com.univ.entity.SshExampleEntity").list();
    }
}
