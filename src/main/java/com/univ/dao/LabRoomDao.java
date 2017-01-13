package com.univ.dao;

import com.univ.entity.LabRoom;

import java.util.List;

/**
 * Created by Univ on 2017/1/9.
 */
public interface LabRoomDao {

    void save(LabRoom labRoom);

    List<LabRoom> getPaginationWithQuery(LabRoom labRoom, int whichPage, int pageSize);

    long totalSize();

    void update(LabRoom labRoom);

    void delete(LabRoom labRoom);

    List<LabRoom> getAll();
}
