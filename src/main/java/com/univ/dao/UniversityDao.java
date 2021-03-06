package com.univ.dao;

import com.univ.entity.EasyUIPage;
import com.univ.entity.University;

import java.util.List;

/**
 * Created by Univ on 2017/1/10.
 */
public interface UniversityDao {

    void save(University university);

    void delete(University university);

    void update(University university);

    List<University> getPaginationWithQuery(University university,  EasyUIPage easyUIPage);

    long totalSize();

    List<University> getAll();
}
