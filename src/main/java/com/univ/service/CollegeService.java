package com.univ.service;

import com.univ.entity.College;
import com.univ.entity.EasyUIPage;

import java.util.List;

/**
 * Created by Univ on 2017/1/10.
 */
public interface CollegeService {

    void save(College college);

    List<College> getPaginationWithQuery(College college, EasyUIPage easyUIPage);

    /**
     * 总记录数
     * @return
     */
    long totalSize();

    void update(College college);

    void delete(College college);
}
