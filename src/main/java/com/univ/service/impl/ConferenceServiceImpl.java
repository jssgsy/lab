package com.univ.service.impl;

import com.univ.dao.ConferenceDao;
import com.univ.entity.Conference;
import com.univ.entity.EasyUIPage;
import com.univ.service.ConferenceService;
import com.univ.service.ConferenceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Univ
 * 2017/1/11 21:00
 */
@Service
public class ConferenceServiceImpl implements ConferenceService {

    @Autowired
    private ConferenceDao conferenceDao;

    public void save(Conference conference) {
        conferenceDao.save(conference);
    }

    public void update(Conference conference) {
        conferenceDao.update(conference);
    }

    public void delete(Conference conference) {
        conferenceDao.delete(conference);
    }

    public List<Conference> getPaginationWithQuery(Conference conference, EasyUIPage easyUIPage) {
        return conferenceDao.getPaginationWithQuery(conference,easyUIPage);
    }

    public long totalSize() {
        return conferenceDao.totalSize();
    }
}
