package com.univ.dao.impl;

import com.univ.dao.AcademicPaperDao;
import com.univ.entity.AcademicPaper;
import com.univ.entity.LabRoom;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Univ
 * 2017/1/11 20:56
 */

@Repository
public class AcademicPaperDaoImpl extends AbstractBaseDao implements AcademicPaperDao {

    public void save(AcademicPaper paper) {
        getCurrentSession().save(paper);
    }

    public void update(AcademicPaper paper) {
        getCurrentSession().update(paper);
    }

    public void delete(AcademicPaper paper) {
        getCurrentSession().delete(paper);
    }

    public List<AcademicPaper> getPaginationWithQuery(AcademicPaper paper, int whichPage, int pageSize) {
        Query query = getCurrentSession().createQuery("from com.univ.entity.AcademicPaper  where name like :name");
        query.setString("name", "%" + paper.getName() + "%");
        query.setFirstResult(whichPage);
        query.setMaxResults(pageSize);
        return query.list();
    }

    public long totalSize() {
        return ((Number)getCurrentSession().createQuery("select count(id) from com.univ.entity.AcademicPaper").uniqueResult()).intValue();
    }
}
