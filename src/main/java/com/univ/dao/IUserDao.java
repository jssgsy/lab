package com.univ.dao;

import com.univ.entity.UserEntity;

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

    void save(UserEntity user);

    /**
     * 登录时查询此用户是否存在
     * @param user
     * @return
     */
    boolean contains(UserEntity user);
}
