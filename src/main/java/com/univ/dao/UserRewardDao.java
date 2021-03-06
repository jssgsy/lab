package com.univ.dao;

import com.univ.entity.EasyUIPage;
import com.univ.entity.UserReward;

import java.util.List;

/**
 * Created by Univ on 2017/2/17.
 */
public interface UserRewardDao {
    void save(UserReward userReward);

    void update(UserReward userReward);

    void delete(UserReward userReward);

    List<UserReward> getPaginationWithQuery(UserReward userReward, EasyUIPage easyUIPage);

    long totalSize();
}
