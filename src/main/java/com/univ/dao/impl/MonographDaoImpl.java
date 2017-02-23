package com.univ.dao.impl;

import com.univ.dao.MonographDao;
import com.univ.entity.EasyUIPage;
import com.univ.entity.Monograph;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Univ
 * 2017/1/11 20:56
 */

@Repository
public class MonographDaoImpl extends AbstractBaseDao implements MonographDao {

    public void save(Monograph monograph) {
        getCurrentSession().save(monograph);
    }

    public void update(Monograph monograph) {
        getCurrentSession().update(monograph);
    }

    public void delete(Monograph monograph) {
        getCurrentSession().delete(monograph);
    }

    //todo:或许可以参考RoleDaoImpl的getLinkedMenus方法
    public List<Monograph> getPaginationWithQuery(Monograph monograph, EasyUIPage easyUIPage) {
        Query query = getCurrentSession().createQuery("from com.univ.entity.Monograph  where name like :name");
        query.setString("name", "%" + monograph.getName() + "%");
        query.setFirstResult(easyUIPage.getWhichPage());
        query.setMaxResults(easyUIPage.getPageSize());
        List<Monograph> list = query.list();


        return list;
    }

    public long totalSize() {
        return ((Number)getCurrentSession().createQuery("select count(id) from com.univ.entity.Monograph").uniqueResult()).intValue();
    }
}
