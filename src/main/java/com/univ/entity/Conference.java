package com.univ.entity;

/**
 * Univ
 * 2017/2/21 19:42
 */

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * 实验室所开会议
 */
public class Conference {

    private Long id;
    private String code;
    private String name;
    private String content;//会议主要内容简介；
    private String address;//会议地址
    private Date conferenceDate;//会议日期
    private Integer shouldArrivalNum;//应到人数
    private Integer actualArrivalNum;//实到人数
    private String remark;

    private User host;//会议主持人；
    private Set<User> participatorSet = new HashSet<User>();//到会者


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

    public User getHost() {
        return host;
    }

    public void setHost(User host) {
        this.host = host;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getConferenceDate() {
        return conferenceDate;
    }

    public void setConferenceDate(Date conferenceDate) {
        this.conferenceDate = conferenceDate;
    }

    public Integer getShouldArrivalNum() {
        return shouldArrivalNum;
    }

    public void setShouldArrivalNum(Integer shouldArrivalNum) {
        this.shouldArrivalNum = shouldArrivalNum;
    }

    public Integer getActualArrivalNum() {
        return actualArrivalNum;
    }

    public void setActualArrivalNum(Integer actualArrivalNum) {
        this.actualArrivalNum = actualArrivalNum;
    }

    public Set<User> getParticipatorSet() {
        return participatorSet;
    }

    public void setParticipatorSet(Set<User> participatorSet) {
        this.participatorSet = participatorSet;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
