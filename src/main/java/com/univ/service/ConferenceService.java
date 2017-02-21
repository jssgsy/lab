package com.univ.service;

import com.univ.entity.Conference;
import com.univ.entity.EasyUIPage;

import java.util.List;

/**
 * Created by Univ on 2017/1/11.
 */
public interface ConferenceService {

    void save(Conference conference);

    void update(Conference conference);

    void delete(Conference conference);

    List<Conference> getPaginationWithQuery(Conference conference, EasyUIPage easyUIPage);

    /**
     * 总记录数
     * @return
     */
    long totalSize();
}
