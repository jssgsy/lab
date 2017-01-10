package com.univ.dao.impl;

import com.univ.dao.UniversityDao;
import com.univ.entity.University;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Univ
 * 2017/1/10 16:51
 */

@Repository
public class UniversityDaoImpl extends AbstractBaseDao implements UniversityDao {

    public void save(University university) {
        getCurrentSession().save(university);
    }

    public void delete(University university) {
        getCurrentSession().delete(university);
    }

    public void update(University university) {
        getCurrentSession().update(university);
    }

    public List<University> getPaginationWithQuery(University university, int whichPage, int pageSize) {
        Query query = getCurrentSession().createQuery("from com.univ.entity.University where name like :name");
        query.setString("name", "%" + university.getName() + "%");
        query.setFirstResult(whichPage);
        query.setMaxResults(pageSize);
        return query.list();
    }

    public long totalSize() {
        Query query = getCurrentSession().createQuery("select count(id) from com.univ.entity.University");
        return ((Number)query.uniqueResult()).intValue();
    }

}
