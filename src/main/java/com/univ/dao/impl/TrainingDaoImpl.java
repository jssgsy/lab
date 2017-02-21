package com.univ.dao.impl;

import com.univ.dao.TrainingDao;
import com.univ.dao.TrainingDao;
import com.univ.entity.EasyUIPage;
import com.univ.entity.Training;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Univ
 * 2017/1/9 21:49
 */
@Repository
public class TrainingDaoImpl extends AbstractBaseDao implements TrainingDao {

    public void save(Training training) {
        getCurrentSession().save(training);
    }

    //todo:在关联关系方面，list()方法忽始终采取延迟加载，这里为何可以找出training关联的user？
    public List<Training> getPaginationWithQuery(Training training, EasyUIPage easyUIPage) {
        Query query = getCurrentSession().createQuery("select lab from com.univ.entity.Training as lab  where name like :name");
        query.setString("name", "%" + training.getName() + "%");
        query.setFirstResult(easyUIPage.getWhichPage());
        query.setMaxResults(easyUIPage.getPageSize());
        List<Training> list = query.list();
        return list;
    }

    public long totalSize() {
        Long count =  (Long) getCurrentSession().createQuery("select count(id) from com.univ.entity.Training").uniqueResult();
        return count.intValue();
    }

    public void update(Training training) {
        getCurrentSession().update(training);
    }

    public void delete(Training training) {
        getCurrentSession().delete(training);
    }

    public List<Training> getAll() {
        return getCurrentSession().createQuery("from com.univ.entity.Training").list();
    }
}
