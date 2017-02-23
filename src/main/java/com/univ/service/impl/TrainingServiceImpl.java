package com.univ.service.impl;

import com.univ.dao.TrainingDao;
import com.univ.entity.EasyUIPage;
import com.univ.entity.Training;
import com.univ.service.TrainingService;
import com.univ.service.TrainingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Univ
 * 2017/1/9 21:45
 */
@Service
public class TrainingServiceImpl implements TrainingService {

    @Autowired
    private TrainingDao trainingDao;

    public void save(Training training) {
        trainingDao.save(training);
    }

    public List<Training> getPaginationWithQuery(Training training, EasyUIPage easyUIPage) {
        return trainingDao.getPaginationWithQuery(training,easyUIPage);
    }

    public long totalSize() {
        return trainingDao.totalSize();
    }

    public void update(Training training) {
        trainingDao.update(training);
    }

    public void delete(Training training) {
        trainingDao.delete(training);
    }

    public List<Training> getAll() {
        return trainingDao.getAll();
    }

    public Training getById(Long id) {
        return trainingDao.getById(id);
    }
}
