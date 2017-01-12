package com.univ.dao;

import com.univ.entity.AcademicPaper;

import java.util.List;

/**
 * Created by Univ on 2017/1/11.
 */
public interface AcademicPaperDao {
    
    void save(AcademicPaper paper);

    void update(AcademicPaper paper);

    void delete(AcademicPaper paper);


    List<AcademicPaper> getPaginationWithQuery(AcademicPaper paper, int whichPage, int pageSize);

    long totalSize();
}
