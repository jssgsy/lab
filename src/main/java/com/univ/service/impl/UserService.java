package com.univ.service.impl;

import com.univ.dao.IUserDao;
import com.univ.entity.User;
import com.univ.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Univ
 * 2017/1/4 20:20
 */
@Service
public class UserService implements IUserService {

    @Autowired
    private IUserDao userDao;

    public boolean verified(User user) {
        return userDao.contains(user);
    }

    public boolean registered(String username) {
        return userDao.registered(username);
    }

    public void save(User user) {
        userDao.save(user);
    }

    public List<User> getAll(int whichPage, int pageSize) {
        return userDao.getAll(whichPage, pageSize);
    }

    public int totalSize() {
        return userDao.totalSize();
    }
}
