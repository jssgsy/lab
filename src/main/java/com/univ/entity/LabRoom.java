package com.univ.entity;

/**
 * Univ
 * 2017/1/9 21:33
 */

/**
 * 实验室
 * //todo:新增字段：建立时间，实验室编号，简称
 */
public class LabRoom {

    private Long id;
    private String name;

    //todo:可考虑将此字段细分
    private String address;

    private User director;//实验室负责人

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
}
