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

    //重点：一点启示，将获取所有的顶层结点和特定的顶层结点通过一个查询参数合二为一。
    public List<Dictionary> getTopDictionaries(String name) {
        String hql = null;
        Query query = null;
        if (null == name || null == name.trim()) {//获取所有的顶层项
            hql = "from com.univ.entity.Dictionary where parent is null";
            query = getCurrentSession().createQuery(hql);
        }else {//获取指定的顶层项
            hql = "from com.univ.entity.Dictionary where parent.name = :name";
            query = getCurrentSession().createQuery(hql);
            query.setString("name", name);
        }
        return query.list();

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
