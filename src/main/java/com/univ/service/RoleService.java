package com.univ.service;

import com.univ.entity.EasyUIPage;
import com.univ.entity.Menu;
import com.univ.entity.Role;

import java.util.List;
import java.util.Set;

/**
 * Created by Univ on 2017/2/17.
 */
public interface RoleService {

    void save(Role role);

    void update(Role role);

    void delete(Role role);

    List<Role> getPaginationWithQuery(Role role, EasyUIPage easyUIPage);

    long totalSize();

    List<Role> getAll();

    /**
     * 获取主键为id的角色所关联的角色
     * @param id
     * @return
     */
    Set<Menu> getLinkedMenus(Long id);
}
