package com.univ.entity;

/**
 * Univ
 * 2017/1/10 18:44
 */

import java.util.Date;

/**
 * 学院实体
 *
 * todo:这里只考虑院长，没有考虑副院长，后期可以加上
 */
public class College {

    private Long id;

    private String name;

    private String code;//编号

    private String shortName;//简称

    private Date buildDate;//建立时间

    private String description;//简单介绍

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

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getShortName() {
        return shortName;
    }

    public void setShortName(String shortName) {
        this.shortName = shortName;
    }

    public Date getBuildDate() {
        return buildDate;
    }

    public void setBuildDate(Date buildDate) {
        this.buildDate = buildDate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
