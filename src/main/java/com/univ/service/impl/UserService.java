package com.univ.service.impl;

import com.univ.dao.IUserDao;
import com.univ.entity.UserEntity;
import com.univ.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Univ
 * 2017/1/4 20:20
 */
@Service
public class UserService implements IUserService {

    @Autowired
    private IUserDao userDao;

    public boolean verified(UserEntity user) {
        return userDao.contains(user);
    }

    public boolean registered(String username) {
        return userDao.registered(username);
    }

    public void save(UserEntity user) {
        userDao.save(user);
    }
}
