package com.univ.entity;

/**
 * Univ
 * 2017/2/24 10:40
 */

import java.util.Date;

/**
 * 实验室经费
 */
public class LabFund {

    private Long id;
    private String code;
    private String content;//经费用途
    private Double totalPrice;//经费数量

    private Long fundType;//经费类别

    private User keeper;//经手人

    private LabRoom labRoom;//经费用于哪个实验室

    private Date applyDate;//经费申请时间

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

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public Long getFundType() {
        return fundType;
    }

    public void setFundType(Long fundType) {
        this.fundType = fundType;
    }

    public Date getApplyDate() {
        return applyDate;
    }

    public void setApplyDate(Date applyDate) {
        this.applyDate = applyDate;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public User getKeeper() {
        return keeper;
    }

    public void setKeeper(User keeper) {
        this.keeper = keeper;
    }

    public LabRoom getLabRoom() {
        return labRoom;
    }

    public void setLabRoom(LabRoom labRoom) {
        this.labRoom = labRoom;
    }
}
