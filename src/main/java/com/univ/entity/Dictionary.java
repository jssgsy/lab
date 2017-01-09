package com.univ.entity;

/**
 * Univ
 * 2017/1/9 18:47
 */

/**
 * 数据字典，数据字典也是树形结构。
 *
 * 数据字典的树形只允许两级
 */
public class Dictionary {

    private Long id;
    private String name;
    private String description;

    private Dictionary parent;

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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Dictionary getParent() {
        return parent;
    }

    public void setParent(Dictionary parent) {
        this.parent = parent;
    }
}
