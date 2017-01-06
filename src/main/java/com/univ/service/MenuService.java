package com.univ.service;

import com.univ.entity.Menu;

import java.util.List;

/**
 * Created by Univ on 2017/1/6.
 */
public interface MenuService {

    /**
     * 返回顶层的菜单
     * @return
     */
    List<Menu> getTopMenus();

    /**
     * 获取直接子菜单
     * @param id
     * @return
     */
    List<Menu> getChildrenById(Long id);

    /**
     * 是否有子结点
     * @param id
     * @return
     */
    boolean hasChildren(Long id);

    /**
     * 获取所有的菜单
     * @return
     */
    List<Menu> getAll();

    /**
     * 更新menu
     * @param menu
     */
    void update(Menu menu);
}
