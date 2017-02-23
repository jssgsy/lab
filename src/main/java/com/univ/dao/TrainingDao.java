package com.univ.dao;

import com.univ.entity.EasyUIPage;
import com.univ.entity.Training;

import java.util.List;

/**
 * Created by Univ on 2017/1/9.
 */
public interface TrainingDao {

    void save(Training training);

    List<Training> getPaginationWithQuery(Training training, EasyUIPage easyUIPage);

    long totalSize();

    void update(Training training);

    void delete(Training training);

    List<Training> getAll();

    Training getById(Long id);
}
