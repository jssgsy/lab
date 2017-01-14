package com.univ.dao.impl;

import com.univ.dao.IUserDao;
import com.univ.entity.EasyUIPage;
import com.univ.entity.User;
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
        Query query = getCurrentSession().createQuery("from com.univ.entity.User as u where u.username =:username");
        query.setString("username", username);
        List list = query.list();

        //重要：query.list()永远不会返回null，所以判断是否查询到有值不能看list=是否ull
        if (list.size() == 0) {
            return false;
        }
        return true;
    }

    public void save(User user) {
        getCurrentSession().save(user);
    }

    public boolean contains(User user) {
        Query query = getCurrentSession().createQuery("from com.univ.entity.User as u where u.username =:username " +
                " and u.password =:password");
        query.setString("username", user.getUsername());
        query.setString("password", user.getPassword());
        List list = query.list();
        if (list.size() == 0) {
            return false;
        }
        return true;
    }

    public List<User> getPaginationWithQuery(User user, EasyUIPage easyUIPage) {
        Query query = getCurrentSession().createQuery("from com.univ.entity.User where username like :username and labRoom.name like :labRoomName");
        query.setString("username", "%" + user.getUsername() + "%");
        query.setString("labRoomName", "%" + user.getLabRoom().getName() + "%");
        query.setFirstResult(easyUIPage.getWhichPage());
        query.setMaxResults(easyUIPage.getPageSize());
        return query.list();
    }

    /**
     * 重点：经验证，下面的hql语句返回的类型为Long，可能因为id是Long类型的原因(即使将这里的id改成*也是Long型)
     * @return
     */
    public long totalSize() {
        return ((Number) getCurrentSession().createQuery("select count(id) from com.univ.entity.User").uniqueResult()).intValue();
    }

    public void update(User user) {
        getCurrentSession().update(user);
    }

    public void delete(User user) {
        getCurrentSession().delete(user);
    }

    public List<User> getAll() {
        return getCurrentSession().createQuery("from com.univ.entity.User").list();
    }

}
