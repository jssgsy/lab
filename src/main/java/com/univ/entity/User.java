package com.univ.entity;

/**
 * Univ
 * 2017/1/4 19:44
 */

import java.util.Date;

/**
 * 实验室用户
 *
 * todo:实验室用户应该和实验室关联
 * todo:考虑只能使用邮箱登录，用户名只用于显示
 * todo: 新增字段 、，、学制、所学专业、文化程序、、
 */
public class User {

    private Long id;
    private String username;
    private String password;

    private String telephone;
    private String email;

    private String sex;//性别
    private Date birthday;//出生年月
    private Date enrolDate;//入学年月
    private Integer specialty;//专业，放入数据字典中；//todo：这里命名有误
    private Integer education;//文化程度，放入数据字典中；
    private String remark;//备注

    private LabRoom labRoom;//所属实验室,单向多对一

    /*
    这里设计成每个用户只有有一个角色而不是多个角色，所以用户与角色是多对一的关系
     */
    private Role role;//实验室人员，学校管理员，超级管理员

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public LabRoom getLabRoom() {
        return labRoom;
    }

    public void setLabRoom(LabRoom labRoom) {
        this.labRoom = labRoom;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public Date getEnrolDate() {
        return enrolDate;
    }

    public void setEnrolDate(Date enrolDate) {
        this.enrolDate = enrolDate;
    }

    public Integer getSpecialty() {
        return specialty;
    }

    public void setSpecialty(Integer specialty) {
        this.specialty = specialty;
    }

    public Integer getEducation() {
        return education;
    }

    public void setEducation(Integer education) {
        this.education = education;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }
}
