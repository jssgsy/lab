package com.univ.dao;

import com.univ.entity.EasyUIPage;
import com.univ.entity.LabRoom;

import java.util.List;

/**
 * Created by Univ on 2017/1/9.
 */
public interface LabRoomDao {

    void save(LabRoom labRoom);

    List<LabRoom> getPaginationWithQuery(LabRoom labRoom, EasyUIPage easyUIPage);

    long totalSize();

    void update(LabRoom labRoom);

    void delete(LabRoom labRoom);

    List<LabRoom> getAll();
}
