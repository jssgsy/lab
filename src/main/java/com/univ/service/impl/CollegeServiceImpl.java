package com.univ.service.impl;

import com.univ.dao.CollegeDao;
import com.univ.entity.College;
import com.univ.service.CollegeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Univ
 * 2017/1/10 20:43
 */

@Service
public class CollegeServiceImpl implements CollegeService {

    @Autowired
    private CollegeDao collegeDao;

    public void save(College college) {
        collegeDao.save(college);
    }

    public List<College> getPaginationWithQuery(College college, int whichPage, int pageSize) {
        return collegeDao.getPaginationWithQuery(college,whichPage,pageSize);
    }

    public long totalSize() {
        return collegeDao.totalSize();
    }

    public void update(College college) {
        collegeDao.update(college);
    }

    public void delete(College college) {
        collegeDao.delete(college);
    }
}
