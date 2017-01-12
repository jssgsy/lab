package com.univ.entity;

/**
 * Univ
 * 2017/1/11 20:15
 */

import java.util.Date;

/**
 * 实验室人员发表论文实体
 *
 * 和User是双向一对多关系
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

    private User author;//论文第一作者，todo:这里需要改成有好几个作者,页面上需要增加按作者名查询

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

    public User getAuthor() {
        return author;
    }

    public void setAuthor(User author) {
        this.author = author;
    }
}
