package com.univ.entity;

/**
 * Univ
 * 2017/1/11 20:15
 */

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 实验室人员发表论文实体
 *
 * 和User是单向多对多关系
 */
public class AcademicPaper {

    private Long id;

    private String name;

    private Date publishDate;//发表日期

    private String hiredInstitution;//论文录用机构

    /*
        论文级别
        0:国际期刊；
        1:国家期刊；
        2:省级期刊;
        3:校级期刊；
     */
    private Integer level;

    private Boolean wasSCI;//注意不要定义成isSCI,否则生成的getter/setter会省略到is

    private String remark;//备注

    //论文的作者，允许多个，且允许作者的顺序之分，因此使用list
    private List<User> authorList = new ArrayList<User>();

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

    public Date getPublishDate() {
        return publishDate;
    }

    public void setPublishDate(Date publishDate) {
        this.publishDate = publishDate;
    }

    public String getHiredInstitution() {
        return hiredInstitution;
    }

    public void setHiredInstitution(String hiredInstitution) {
        this.hiredInstitution = hiredInstitution;
    }

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

    public Boolean getWasSCI() {
        return wasSCI;
    }

    public void setWasSCI(Boolean wasSCI) {
        this.wasSCI = wasSCI;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public List<User> getAuthorList() {
        return authorList;
    }

    public void setAuthorList(List<User> authorList) {
        this.authorList = authorList;
    }
}
