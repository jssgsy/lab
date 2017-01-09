package com.univ.dao.impl;

import com.univ.dao.DictionaryDao;
import com.univ.entity.Dictionary;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Univ
 * 2017/1/6 16:02
 */

@Repository
public class DictionaryDaoImpl extends AbstractBaseDao implements DictionaryDao {

    //顶层菜单的pId为null,注意，hql是面向对象的查询语句，pId不是Dictionary的属性
    public List<Dictionary> getTopDictionarys() {
        return getCurrentSession().createQuery("from com.univ.entity.Dictionary where parent is null").list();

    }

    public List<Dictionary> getChildrenById(Long id) {
        Query query = getCurrentSession().createQuery("from com.univ.entity.Dictionary as m where m.parent = :id");
        query.setLong("id", id);
        return query.list();
    }

    public boolean hasChildren(Long id) {
        Query query = getCurrentSession().createQuery("from com.univ.entity.Dictionary as m where m.parent = :id ");
        query.setLong("id", id);
        List list = query.list();
        if (list.size() > 0) {
            return true;
        }
        return false;
    }

    public List<Dictionary> getAll() {
        return getCurrentSession().createQuery("from com.univ.entity.Dictionary").list();
    }

    public void update(Dictionary Dictionary) {
        getCurrentSession().update(Dictionary);
    }

    public void save(Dictionary Dictionary) {
        getCurrentSession().save(Dictionary);
    }

    public void delete(Dictionary Dictionary) {
        getCurrentSession().delete(Dictionary);
    }
}
