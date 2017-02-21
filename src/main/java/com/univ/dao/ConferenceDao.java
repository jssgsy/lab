package com.univ.dao;

import com.univ.entity.Conference;
import com.univ.entity.EasyUIPage;

import java.util.List;

/**
 * Created by Univ on 2017/1/11.
 */
public interface ConferenceDao {
    
    void save(Conference conference);

    void update(Conference conference);

    void delete(Conference conference);


    List<Conference> getPaginationWithQuery(Conference conference, EasyUIPage easyUIPage);

    long totalSize();
}
