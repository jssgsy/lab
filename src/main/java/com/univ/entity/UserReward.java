package com.univ.entity;

/**
 * Univ
 * 2017/2/17 08:59
 */

import java.util.Date;

/**
 * 实验室用户的奖励
 */
public class UserReward {
    private Long id;

    private String name;// 奖励名称或成果名称

    private Date rewardDate;// 获奖日期

    private Integer level;// 获奖级别,0.未获奖，1.国际奖，2.国家奖，3.省市部委，4.校级奖

    private Boolean patented = false;//是否发明专利

    //todo：后期考虑去掉此字段
    private Boolean verified = false;//是否通过审核，默认新增的数据需要经过审核

    private String remark;// 备注

    private User user;// 获奖人

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

    public Date getRewardDate() {
        return rewardDate;
    }

    public void setRewardDate(Date rewardDate) {
        this.rewardDate = rewardDate;
    }

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

    public Boolean getPatented() {
        return patented;
    }

    public void setPatented(Boolean patented) {
        this.patented = patented;
    }

    public Boolean getVerified() {
        return verified;
    }

    public void setVerified(Boolean verified) {
        this.verified = verified;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
