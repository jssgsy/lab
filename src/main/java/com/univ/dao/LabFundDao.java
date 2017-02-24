package com.univ.dao;

import com.univ.entity.EasyUIPage;
import com.univ.entity.LabFund;

import java.util.List;

/**
 * Created by Univ on 2017/1/9.
 */
public interface LabFundDao {

    void save(LabFund labFund);

    List<LabFund> getPaginationWithQuery(LabFund labFund, EasyUIPage easyUIPage);

    long totalSize();

    void update(LabFund labFund);

    void delete(LabFund labFund);

    List<LabFund> getAll();
}
