package com.univ.service;

import com.univ.entity.EasyUIPage;
import com.univ.entity.LabFund;

import java.util.List;

/**
 * Created by Univ on 2017/1/9.
 */
public interface LabFundService {

   

    void save(LabFund labFund);

    List<LabFund> getPaginationWithQuery(LabFund labFund, EasyUIPage easyUIPage);

    /**
     * 总记录数
     * @return
     */
    long totalSize();

    void update(LabFund labFund);

    void delete(LabFund labFund);

    List<LabFund> getAll();
}
