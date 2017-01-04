package com.univ.dao;

import com.univ.entity.SshExampleEntity;

import java.io.Serializable;
import java.util.List;

/**
 * Created by Univ on 16/5/19.
 */

/**
 * 具体的dao在基类dao中进行功能的扩展
 */
public interface ISshExampleDao {

    /*
	 * 保存一个对象
	 */
    Serializable save(SshExampleEntity entity);

    /*
     * 删除一个对象
     */
    void delete(SshExampleEntity entity);

    /*
     * 更新对象
     */
    void update(Object entity);

    /*
     * 根据id立即加载对象
     */
    SshExampleEntity get(Class entityClass, Serializable id);

    /*
     * 根据id延迟加载对象
     */
    SshExampleEntity load(Class entityClass, Serializable id);

    /*
     * 立即加载所有的Category对象
     */
    List<SshExampleEntity> getAll();

}
