package com.univ.dao.impl;

import com.univ.dao.IUserDao;
import com.univ.entity.UserEntity;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Univ
 * 2017/1/4 21:15
 */
@Repository
public class UserDao extends AbstractBaseDao implements IUserDao {

    public boolean registered(String username) {
        //重要：:=后不能有空格。
        Query query = getCurrentSession().createQuery("from com.univ.entity.UserEntity as u where u.username =:username");
        query.setString("username", username);
        List list = query.list();

        //重要：query.list()永远不会返回null，所以判断是否查询到有值不能看list=是否ull
        if (list.size() == 0) {
            return false;
        }
        return true;
    }

    public void save(UserEntity user) {
        getCurrentSession().save(user);
    }

    public boolean contains(UserEntity user) {
        Query query = getCurrentSession().createQuery("from com.univ.entity.UserEntity as u where u.username =:username " +
                " and u.password =:password");
        query.setString("username", user.getUsername());
        query.setString("password", user.getPassword());
        List list = query.list();
        if (list.size() == 0) {
            return false;
        }
        return true;
    }

}
