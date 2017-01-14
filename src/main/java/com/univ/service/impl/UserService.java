package com.univ.service.impl;

import com.univ.dao.IUserDao;
import com.univ.entity.EasyUIPage;
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

    public List<User> getPaginationWithQuery(User user, EasyUIPage easyUIPage) {
        return userDao.getPaginationWithQuery(user, easyUIPage);
    }

    public long totalSize() {
        return userDao.totalSize();
    }

    public void update(User user) {
        userDao.update(user);
    }

    public void delete(User user) {
        userDao.delete(user);
    }

    public List<User> getAll() {
        return userDao.getAll();
    }
}
