package com.univ.dao.impl;

import com.univ.dao.LabRoomDao;
import com.univ.entity.EasyUIPage;
import com.univ.entity.LabRoom;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Univ
 * 2017/1/9 21:49
 */
@Repository
public class LabRoomDaoImpl extends AbstractBaseDao implements LabRoomDao {

    public void save(LabRoom labRoom) {
        getCurrentSession().save(labRoom);
    }

    //todo:在关联关系方面，list()方法忽始终采取延迟加载，这里为何可以找出labRoom关联的user？
    public List<LabRoom> getPaginationWithQuery(LabRoom labRoom, EasyUIPage easyUIPage) {
        Query query = getCurrentSession().createQuery("select lab from com.univ.entity.LabRoom as lab  where name like :name");
        query.setString("name", "%" + labRoom.getName() + "%");
        query.setFirstResult(easyUIPage.getWhichPage());
        query.setMaxResults(easyUIPage.getPageSize());
        List<LabRoom> list = query.list();
        return list;
    }

    public long totalSize() {
        Long count =  (Long) getCurrentSession().createQuery("select count(id) from com.univ.entity.LabRoom").uniqueResult();
        return count.intValue();
    }

    public void update(LabRoom labRoom) {
        getCurrentSession().update(labRoom);
    }

    public void delete(LabRoom labRoom) {
        getCurrentSession().delete(labRoom);
    }

    public List<LabRoom> getAll() {
        return getCurrentSession().createQuery("from com.univ.entity.LabRoom").list();
    }
}
