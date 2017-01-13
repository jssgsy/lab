package com.univ.entity;

/**
 * Univ
 * 2017/1/10 16:29
 */

import java.util.Date;

/**
 * 大学实体
 *
 * todo：后期插入数据时需要判断是否重复插入，大致思路：利用property属性的unique，然后明确此种异常类型并在struts2中进行配置
 */
public class University {

    private Long id;
    private String name;
    private String code;//编号

    private String shortName;//简称

    private Date buildDate;//建立时间

    private String description;//简单介绍

    private String address;

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
