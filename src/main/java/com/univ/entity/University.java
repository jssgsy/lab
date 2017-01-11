package com.univ.entity;

/**
 * Univ
 * 2017/1/10 16:29
 */

/**
 * 大学实体
 *
 * todo:新增字段 ： 学校编号(作为唯一字段),建立时间，简称，简介，
 *
 * todo：后期插入数据时需要判断是否重复插入，大致思路：利用property属性的unique，然后明确此种异常类型并在struts2中进行配置
 */
public class University {

    private Long id;
    private String name;
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
}
