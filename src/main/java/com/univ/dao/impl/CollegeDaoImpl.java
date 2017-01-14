package com.univ.dao.impl;

import com.univ.dao.CollegeDao;
import com.univ.entity.College;
import com.univ.entity.EasyUIPage;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Univ
 * 2017/1/10 20:38
 */

@Repository
public class CollegeDaoImpl extends AbstractBaseDao implements CollegeDao {

    public void save(College college) {
        getCurrentSession().save(college);
    }

    public List<College> getPaginationWithQuery(College college, EasyUIPage easyUIPage) {
        Query query = getCurrentSession().createQuery("select lab from com.univ.entity.College as lab  where name like :name");
        query.setString("name", "%" + college.getName() + "%");
        query.setFirstResult(easyUIPage.getWhichPage());
        query.setMaxResults(easyUIPage.getPageSize());
        return query.list();
    }

    public long totalSize() {
        Query query = getCurrentSession().createQuery("select count(id) from com.univ.entity.College");
        return ((Number)query.uniqueResult()).intValue();
    }

    public void update(College college) {
        getCurrentSession().update(college);
    }

    public void delete(College college) {
        getCurrentSession().delete(college);
    }
}
