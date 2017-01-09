package com.univ.dao;

import com.univ.entity.Menu;

import java.util.List;

/**
 * Created by Univ on 2017/1/6.
 */
public interface MenuDao {

    List<Menu> getTopMenus();

    List<Menu> getChildrenById(Long id);

    boolean hasChildren(Long id);

    List<Menu> getAll();

    void update(Menu menu);

    void save(Menu menu);

    void delete(Menu menu);
}
