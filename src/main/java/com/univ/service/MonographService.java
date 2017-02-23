package com.univ.service;

import com.univ.entity.EasyUIPage;
import com.univ.entity.Monograph;

import java.util.List;

/**
 * Created by Univ on 2017/1/11.
 */
public interface MonographService {

    void save(Monograph monograph);

    void update(Monograph monograph);

    void delete(Monograph monograph);

    List<Monograph> getPaginationWithQuery(Monograph monograph, EasyUIPage easyUIPage);

    /**
     * 总记录数
     * @return
     */
    long totalSize();
}
