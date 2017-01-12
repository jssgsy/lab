package com.univ.service.impl;

import com.univ.dao.AcademicPaperDao;
import com.univ.entity.AcademicPaper;
import com.univ.service.AcademicPaperService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Univ
 * 2017/1/11 21:00
 */
@Service
public class AcademicPaperServiceImpl implements AcademicPaperService {

    @Autowired
    private AcademicPaperDao academicPaperDao;

    public void save(AcademicPaper paper) {
        academicPaperDao.save(paper);
    }

    public void update(AcademicPaper paper) {
        academicPaperDao.update(paper);
    }

    public void delete(AcademicPaper paper) {
        academicPaperDao.delete(paper);
    }

    public List<AcademicPaper> getPaginationWithQuery(AcademicPaper paper, int whichPage, int pageSize) {
        return academicPaperDao.getPaginationWithQuery(paper, whichPage, pageSize);
    }

    public long totalSize() {
        return academicPaperDao.totalSize();
    }
}
