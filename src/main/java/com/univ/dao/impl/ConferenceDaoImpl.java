package com.univ.dao.impl;

import com.univ.dao.ConferenceDao;
import com.univ.dao.ConferenceDao;
import com.univ.entity.Conference;
import com.univ.entity.EasyUIPage;
import com.univ.entity.User;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

/**
 * Univ
 * 2017/1/11 20:56
 */

@Repository
public class ConferenceDaoImpl extends AbstractBaseDao implements ConferenceDao {

    public void save(Conference conference) {
        getCurrentSession().save(conference);
    }

    public void update(Conference conference) {
        getCurrentSession().update(conference);
    }

    public void delete(Conference conference) {
        getCurrentSession().delete(conference);
    }

    //todo:或许可以参考RoleDaoImpl的getLinkedMenus方法
    public List<Conference> getPaginationWithQuery(Conference conference, EasyUIPage easyUIPage) {
        Query query = getCurrentSession().createQuery("from com.univ.entity.Conference  where name like :name");
        query.setString("name", "%" + conference.getName() + "%");
        query.setFirstResult(easyUIPage.getWhichPage());
        query.setMaxResults(easyUIPage.getPageSize());
        List<Conference> list = query.list();

        //根据作者名查询，这里实现的不够优雅，不过应该配置的是单向的多对多，似乎也别无他法。

        return list;
    }

    public long totalSize() {
        return ((Number)getCurrentSession().createQuery("select count(id) from com.univ.entity.Conference").uniqueResult()).intValue();
    }
}
