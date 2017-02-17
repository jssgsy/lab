package com.univ.dao;

import com.univ.entity.EasyUIPage;
import com.univ.entity.Menu;
import com.univ.entity.Role;

import java.util.List;
import java.util.Set;

/**
 * Created by Univ on 2017/2/17.
 */
public interface RoleDao{
    void save(Role role);

    void delete(Role role);

    void update(Role role);

    List<Role> getPaginationWithQuery(Role role, EasyUIPage easyUIPage);

    long totalSize();

    List<Role> getAll();

    Set<Menu> getLinkedMenus(Long id);
}
