package com.univ.dao;

import com.univ.entity.College;

import java.util.List;

/**
 * Created by Univ on 2017/1/10.
 */
public interface CollegeDao {
    void save(College college);

    List<College> getPaginationWithQuery(College college, int whichPage, int pageSize);

    long totalSize();

    void update(College college);

    void delete(College college);
}
