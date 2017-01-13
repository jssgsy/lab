package com.univ.entity;

/**
 * Univ
 * 2017/1/9 21:33
 */

import java.util.Date;

/**
 * 实验室
 * //todo:开放时间
 */
public class LabRoom {

    private Long id;
    private String name;

    private String code;//实验室编号

    private String shortName;//简称

    private Date buildDate;//建立时间

    private String description;//简单介绍

    //todo:可考虑将此字段细分
    private String address;

    private User director;//实验室负责人，单向多对一

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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public User getDirector() {
        return director;
    }

    public void setDirector(User director) {
        this.director = director;
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
