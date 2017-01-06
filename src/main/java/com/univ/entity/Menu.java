package com.univ.entity;

/**
 * Univ
 * 2017/1/5 21:26
 */

import java.util.ArrayList;
import java.util.List;

/**
 * 导航栏的菜单实体类
 */
public class Menu {

    private Long id;	//逻辑主键
    private String name;	//菜单名称
    private String url;	//点击触发的访问地址
    private Integer px;	//显示的顺序

    /**
     * 在查询顶层菜单时，逻辑是，所以顶层菜单即没有parent的菜单，所以parent需要定义
     */
    private Menu parent;

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

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Integer getPx() {
        return px;
    }

    public void setPx(Integer px) {
        this.px = px;
    }

    public Menu getParent() {
        return parent;
    }

    public void setParent(Menu parent) {
        this.parent = parent;
    }
}
