package com.univ.service.impl;

import com.univ.dao.UserRewardDao;
import com.univ.entity.EasyUIPage;
import com.univ.entity.UserReward;
import com.univ.service.UserRewardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Univ
 * 2017/2/17 09:27
 */

@Service
public class UserRewardServiceImpl implements UserRewardService {

    @Autowired
    private UserRewardDao userRewardDao;

    public void save(UserReward userReward) {
        userRewardDao.save(userReward);
    }

    public void update(UserReward userReward) {
        userRewardDao.update(userReward);
    }

    public void delete(UserReward userReward) {
        userRewardDao.delete(userReward);
    }

    public List<UserReward> getPaginationWithQuery(UserReward userReward, EasyUIPage easyUIPage) {
        return userRewardDao.getPaginationWithQuery(userReward,easyUIPage);
    }

    public long totalSize() {
        return userRewardDao.totalSize();
    }
}
