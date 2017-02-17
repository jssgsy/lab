package com.univ.entity;

/**
 * Univ
 * 2017/2/17 10:48
 */

import java.util.HashSet;
import java.util.Set;

/**
 * 用户角色
 */
public class Role {

    private Long id;
    private String name;//角色名称
    private String remark;//备注

    /*
    这里将角色与功能菜单设计成单向的一对多关联，而不是双向的多对多关联
     */
    private Set<Menu> menuSet = new HashSet<Menu>();

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Set<Menu> getMenuSet() {
        return menuSet;
    }

    public void setMenuSet(Set<Menu> menuSet) {
        this.menuSet = menuSet;
    }
}
