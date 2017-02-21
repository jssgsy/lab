package com.univ.service;

import com.univ.entity.EasyUIPage;
import com.univ.entity.Training;

import java.util.List;

/**
 * Created by Univ on 2017/1/9.
 */
public interface TrainingService {

   

    void save(Training training);

    List<Training> getPaginationWithQuery(Training training, EasyUIPage easyUIPage);

    /**
     * 总记录数
     * @return
     */
    long totalSize();

    void update(Training training);

    void delete(Training training);

    List<Training> getAll();
}
