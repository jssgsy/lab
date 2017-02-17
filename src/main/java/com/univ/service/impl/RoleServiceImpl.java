package com.univ.service.impl;

import com.univ.dao.RoleDao;
import com.univ.entity.EasyUIPage;
import com.univ.entity.Menu;
import com.univ.entity.Role;
import com.univ.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Set;

/**
 * Univ
 * 2017/2/17 14:49
 */

@Service
public class RoleServiceImpl implements RoleService {
    
    @Autowired
    private RoleDao roleDao;

    public void save(Role role) {
        roleDao.save(role);
    }

    public void delete(Role role) {
        roleDao.delete(role);
    }

    public void update(Role role) {
        roleDao.update(role);
    }

    public List<Role> getPaginationWithQuery(Role role, EasyUIPage easyUIPage) {
        return roleDao.getPaginationWithQuery(role, easyUIPage);
    }

    public long totalSize() {
        return roleDao.totalSize();
    }

    public List<Role> getAll() {
        return roleDao.getAll();
    }

    public Set<Menu> getLinkedMenus(Long id) {
        return roleDao.getLinkedMenus(id);
    }
}
