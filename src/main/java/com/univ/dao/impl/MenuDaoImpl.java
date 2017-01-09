package com.univ.dao.impl;

import com.univ.dao.MenuDao;
import com.univ.entity.Menu;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Univ
 * 2017/1/6 16:02
 */

@Repository
public class MenuDaoImpl extends AbstractBaseDao implements MenuDao {

    //顶层菜单的pId为null,注意，hql是面向对象的查询语句，pId不是Menu的属性
    public List<Menu> getTopMenus() {
        return getCurrentSession().createQuery("from com.univ.entity.Menu where parent is null").list();

    }

    //todo:如果直接使用sql则menu可能不用配置一对多关联，注意这里不用parent.id
    public List<Menu> getChildrenById(Long id) {
        Query query = getCurrentSession().createQuery("from com.univ.entity.Menu as m where m.parent = :id");
        query.setLong("id", id);
        return query.list();
    }

    public boolean hasChildren(Long id) {
        Query query = getCurrentSession().createQuery("from com.univ.entity.Menu as m where m.parent = :id ");
        query.setLong("id", id);
        List list = query.list();
        if (list.size() > 0) {
            return true;
        }
        return false;
    }

    public List<Menu> getAll() {
        return getCurrentSession().createQuery("from com.univ.entity.Menu").list();
    }

    public void update(Menu menu) {
        getCurrentSession().update(menu);
    }

    public void save(Menu menu) {
        getCurrentSession().save(menu);
    }

    public void delete(Menu menu) {
        getCurrentSession().delete(menu);
    }
}
