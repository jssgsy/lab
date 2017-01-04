package com.univ.dao.impl;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;

/** 
 * @author	Univ
 * @date	2016年4月24日 下午12:07:05 
 * @version 1.0
 *
*/

/**
 * 基Dao，供子Dao继承使用。
 *
 * 所有的dao均需要SessionFactory，因此将其抽象至此.
 *
 * 重点：将AbstractBaseDao定义成abstract是因为其不应该被实例化，
 * 重点是，虽然是abstract的，但依然可以注入SessionFactory供子dao使用
 */

public abstract class AbstractBaseDao{

    @Autowired
    private SessionFactory sessionFactory;

    public Session getCurrentSession(){
        return sessionFactory.getCurrentSession();
    }

}

