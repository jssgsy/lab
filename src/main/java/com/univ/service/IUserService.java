package com.univ.service;

import com.univ.entity.EasyUIPage;
import com.univ.entity.User;

import java.util.List;

/**
 * Created by Univ on 2017/1/4.
 */
public interface IUserService {

    boolean verified(User user);

    boolean registered(String username);

    void save(User user);

    List<User> getPaginationWithQuery(User user, EasyUIPage easyUIPage);

    /**
     * 总记录数
     * @return
     */
    long totalSize();

    void update(User user);

    void delete(User user);

    /**
     * 获取所有记录，不分页，不查询，如供实验室选择负责人
     * @return
     */
    List<User> getAll();

    /**
     * 通过用户名和密码查找相应的用户
     * @param username
     * @param password
     * @return
     */
    User find(String username, String password);
}
