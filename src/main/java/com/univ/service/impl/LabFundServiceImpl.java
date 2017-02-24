package com.univ.service.impl;

import com.univ.dao.LabFundDao;
import com.univ.entity.EasyUIPage;
import com.univ.entity.LabFund;
import com.univ.service.LabFundService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Univ
 * 2017/1/9 21:45
 */
@Service
public class LabFundServiceImpl implements LabFundService {

    @Autowired
    private LabFundDao labFundDao;

    public void save(LabFund labFund) {
        labFundDao.save(labFund);
    }

    public List<LabFund> getPaginationWithQuery(LabFund labFund, EasyUIPage easyUIPage) {
        return labFundDao.getPaginationWithQuery(labFund,easyUIPage);
    }

    public long totalSize() {
        return labFundDao.totalSize();
    }

    public void update(LabFund labFund) {
        labFundDao.update(labFund);
    }

    public void delete(LabFund labFund) {
        labFundDao.delete(labFund);
    }

    public List<LabFund> getAll() {
        return labFundDao.getAll();
    }
}
