package com.univ.service;

import com.univ.entity.University;

import java.util.List;

/**
 * Univ
 * 2017/1/10 16:55
 */
public interface UniversityService {

    void save(University university);

    void delete(University university);

    void update(University university);


    List<University> getPaginationWithQuery(University university, int whichPage, int pageSize);

    /**
     * 总记录数
     * @return
     */
    long totalSize();

}
