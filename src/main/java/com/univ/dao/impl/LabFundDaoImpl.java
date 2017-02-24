package com.univ.dao.impl;

import com.univ.dao.LabFundDao;
import com.univ.dao.LabFundDao;
import com.univ.entity.EasyUIPage;
import com.univ.entity.LabFund;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Univ
 * 2017/1/9 21:49
 */
@Repository
public class LabFundDaoImpl extends AbstractBaseDao implements LabFundDao {

    public void save(LabFund labFund) {
        getCurrentSession().save(labFund);
    }

    public List<LabFund> getPaginationWithQuery(LabFund labFund, EasyUIPage easyUIPage) {
        Query query = getCurrentSession().createQuery("select lab from com.univ.entity.LabFund as lab  where content like :content");
        query.setString("content", "%" + labFund.getContent() + "%");
        query.setFirstResult(easyUIPage.getWhichPage());
        query.setMaxResults(easyUIPage.getPageSize());
        List<LabFund> list = query.list();
        return list;
    }

    public long totalSize() {
        Long count =  (Long) getCurrentSession().createQuery("select count(id) from com.univ.entity.LabFund").uniqueResult();
        return count.intValue();
    }

    public void update(LabFund labFund) {
        getCurrentSession().update(labFund);
    }

    public void delete(LabFund labFund) {
        getCurrentSession().delete(labFund);
    }

    public List<LabFund> getAll() {
        return getCurrentSession().createQuery("from com.univ.entity.LabFund").list();
    }
}
