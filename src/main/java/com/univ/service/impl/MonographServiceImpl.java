package com.univ.service.impl;

import com.univ.dao.MonographDao;
import com.univ.entity.EasyUIPage;
import com.univ.entity.Monograph;
import com.univ.service.MonographService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Univ
 * 2017/1/11 21:00
 */
@Service
public class MonographServiceImpl implements MonographService{

    @Autowired
    private MonographDao monographDao;

    public void save(Monograph monograph) {
        monographDao.save(monograph);
    }

    public void update(Monograph monograph) {
        monographDao.update(monograph);
    }

    public void delete(Monograph monograph) {
        monographDao.delete(monograph);
    }

    public List<Monograph> getPaginationWithQuery(Monograph monograph, EasyUIPage easyUIPage) {
        return monographDao.getPaginationWithQuery(monograph,easyUIPage);
    }

    public long totalSize() {
        return monographDao.totalSize();
    }
}
