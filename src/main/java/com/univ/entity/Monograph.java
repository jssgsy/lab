package com.univ.entity;

/**
 * Univ
 * 2017/2/23 20:08
 */

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * 实验室人员出版专著
 */
public class Monograph {

    private Long id;

    private String code;
    private String name;
    private String hiredInstitution;//出版机构
    private Date publishDate;//出版日期
    private Long level;//出版级别
    private Boolean wasVerified = false;//默认为需要审核
    private String remark;
    private Set<User> authorSet = new HashSet<User>();//作者

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

    public Date getPublishDate() {
        return publishDate;
    }

    public void setPublishDate(Date publishDate) {
        this.publishDate = publishDate;
    }

    public Long getLevel() {
        return level;
    }

    public void setLevel(Long level) {
        this.level = level;
    }

    public Set<User> getAuthorSet() {
        return authorSet;
    }

    public void setAuthorSet(Set<User> authorSet) {
        this.authorSet = authorSet;
    }

    public String getHiredInstitution() {
        return hiredInstitution;
    }

    public void setHiredInstitution(String hiredInstitution) {
        this.hiredInstitution = hiredInstitution;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Boolean getWasVerified() {
        return wasVerified;
    }

    public void setWasVerified(Boolean wasVerified) {
        this.wasVerified = wasVerified;
    }
}
