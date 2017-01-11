package com.univ.entity;

/**
 * Univ
 * 2017/1/10 18:44
 */

/**
 * 学院实体
 *
 * todo:这里只考虑院长，没有考虑副院长，后期可以加上
 * todo:新增字段：建立时间、简介、简称、
 */
public class College {

    private Long id;
    private String name;
    private User dean;//院长，一对一关系

    private University university;

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

    public User getDean() {
        return dean;
    }

    public void setDean(User dean) {
        this.dean = dean;
    }

    public University getUniversity() {
        return university;
    }

    public void setUniversity(University university) {
        this.university = university;
    }
}
