package com.univ.service;

import com.univ.entity.UserEntity;

/**
 * Created by Univ on 2017/1/4.
 */
public interface IUserService {

    boolean verified(UserEntity user);

    boolean registered(String username);

    void save(UserEntity user);
}
