package com.univ.dao.impl;

import com.univ.dao.RoleDao;
import com.univ.entity.EasyUIPage;
import com.univ.entity.Menu;
import com.univ.entity.Role;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Set;

/**
 * Univ
 * 2017/2/17 14:52
 */

@Repository
public class RoleDaoImpl extends AbstractBaseDao implements RoleDao {

    public void save(Role role) {
        getCurrentSession().save(role);
    }

    public void delete(Role role) {
        getCurrentSession().delete(role);
    }

    public void update(Role role) {
        getCurrentSession().update(role);
    }

    public List<Role> getPaginationWithQuery(Role role, EasyUIPage easyUIPage) {
        Query query = getCurrentSession().createQuery("from com.univ.entity.Role where name like :name");
        query.setString("name", "%" + role.getName() + "%");
        query.setFirstResult(easyUIPage.getWhichPage());
        query.setMaxResults(easyUIPage.getPageSize());
        return query.list();
    }

    public long totalSize() {
        Query query = getCurrentSession().createQuery("select count(id) from com.univ.entity.Role");
        return ((Number)query.uniqueResult()).intValue();
    }

    public List<Role> getAll() {
        return getCurrentSession().createQuery("from com.univ.entity.Role").list();

    }

    public Set<Menu> getLinkedMenus(Long id) {
        Role role = (Role) getCurrentSession().get(Role.class, id);
        return role.getMenuSet();
    }
}
