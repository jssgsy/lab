package com.univ.service;

import com.univ.entity.User;

import java.util.List;

/**
 * Created by Univ on 2017/1/4.
 */
public interface IUserService {

    boolean verified(User user);

    boolean registered(String username);

    void save(User user);

    List<User> getPaginationWithQuery(User user, int whichPage, int pageSize);

    /**
     * 总记录数
     * @return
     */
    long totalSize();

    void update(User user);

    void delete(User user);
}
