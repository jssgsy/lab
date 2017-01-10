package com.univ.service.impl;

import com.univ.dao.UniversityDao;
import com.univ.entity.University;
import com.univ.service.UniversityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Univ
 * 2017/1/10 16:56
 */
@Service
public class UniversityServiceImpl implements UniversityService {

    @Autowired
    private UniversityDao universityDao;

    public void save(University university) {
        universityDao.save(university);
    }

    public void delete(University university) {
        universityDao.delete(university);
    }

    public void update(University university) {
        universityDao.update(university);
    }

    public List<University> getPaginationWithQuery(University university, int whichPage, int pageSize) {
        return universityDao.getPaginationWithQuery(university,whichPage,pageSize);
    }

    public long totalSize() {
        return universityDao.totalSize();
    }
}
