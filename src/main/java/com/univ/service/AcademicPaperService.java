package com.univ.service;

import com.univ.entity.AcademicPaper;

import java.util.List;

/**
 * Created by Univ on 2017/1/11.
 */
public interface AcademicPaperService {

    void save(AcademicPaper paper);

    void update(AcademicPaper paper);

    void delete(AcademicPaper paper);

    List<AcademicPaper> getPaginationWithQuery(AcademicPaper paper, int whichPage, int pageSize);

    /**
     * 总记录数
     * @return
     */
    long totalSize();
}
