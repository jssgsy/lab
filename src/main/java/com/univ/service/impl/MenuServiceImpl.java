package com.univ.service.impl;

import com.univ.dao.MenuDao;
import com.univ.entity.Menu;
import com.univ.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Univ
 * 2017/1/6 16:00
 */
@Service
public class MenuServiceImpl implements MenuService {

    @Autowired
    private MenuDao menuDao;


    public List<Menu> getTopMenus() {
        return menuDao.getTopMenus();
    }

    public List<Menu> getChildrenById(Long id) {
        return menuDao.getChildrenById(id);
    }

    public boolean hasChildren(Long id) {
        return menuDao.hasChildren(id);
    }

    public List<Menu> getAll() {
        return menuDao.getAll();
    }

    public void update(Menu menu) {
        menuDao.update(menu);
    }

    public void save(Menu menu) {
        menuDao.save(menu);
    }

    public void delete(Menu menu) {
        menuDao.delete(menu);
    }
}
