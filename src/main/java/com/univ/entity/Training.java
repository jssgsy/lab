package com.univ.entity;

/**
 * Univ
 * 2017/2/21 21:34
 */

import java.util.Date;

/**
 * 实验室用户培训记录，包括讲座报告等
 */
public class Training {

    private Long id;
    private String code;
    private String name;//培训名称
    private String content;//培训内容
    private String address;//培训地点
    private String summary;//培训总结

    /**
     * todo:这里考虑将培训类别作为单独的表
     */
    private Long trainingType;//培训类别

    private Date trainingDate;//培训日期

    private User user;//

    private Boolean wasVerified;//是否通过审核

    private String remark;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public Long getTrainingType() {
        return trainingType;
    }

    public void setTrainingType(Long trainingType) {
        this.trainingType = trainingType;
    }

    public Date getTrainingDate() {
        return trainingDate;
    }

    public void setTrainingDate(Date trainingDate) {
        this.trainingDate = trainingDate;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Boolean getWasVerified() {
        return wasVerified;
    }

    public void setWasVerified(Boolean wasVerified) {
        this.wasVerified = wasVerified;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}
