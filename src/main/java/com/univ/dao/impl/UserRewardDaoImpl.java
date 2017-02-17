package com.univ.dao.impl;

import com.univ.dao.UserRewardDao;
import com.univ.entity.EasyUIPage;
import com.univ.entity.UserReward;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Univ
 * 2017/2/17 09:30
 */

@Repository
public class UserRewardDaoImpl extends AbstractBaseDao implements UserRewardDao {

    public void save(UserReward userReward) {
        getCurrentSession().save(userReward);
    }

    public void update(UserReward userReward) {
        getCurrentSession().update(userReward);
    }

    public void delete(UserReward userReward) {
        getCurrentSession().delete(userReward);
    }

    public List<UserReward> getPaginationWithQuery(UserReward userReward, EasyUIPage easyUIPage) {
        Query query = getCurrentSession().createQuery("from com.univ.entity.UserReward where user.username like :username");
        query.setString("username", "%" + userReward.getUser().getUsername() + "%");
        query.setFirstResult(easyUIPage.getWhichPage());
        query.setMaxResults(easyUIPage.getPageSize());
        return query.list();
    }

    public long totalSize() {
        return ((Number)getCurrentSession().createQuery("select count(id) from com.univ.entity.UserReward").uniqueResult()).intValue();
    }
}
