package com.univ.dao;

import com.univ.entity.EasyUIPage;
import com.univ.entity.User;

import java.util.List;

/**
 * Created by Univ on 2017/1/4.
 */
public interface IUserDao {


    /**
     * 注册时查询数据库中是否有此用户名
     * @param username
     * @return
     */
    boolean registered(String username);

    void save(User user);

    /**
     * 登录时查询此用户是否存在
     * @param user
     * @return
     */
    boolean contains(User user);

    List<User> getPaginationWithQuery(User user, EasyUIPage easyUIPage);

    long totalSize();

    void update(User user);

    void delete(User user);

    List<User> getAll();
}
