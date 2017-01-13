package com.univ.service;

import com.univ.entity.LabRoom;

import java.util.List;

/**
 * Created by Univ on 2017/1/9.
 */
public interface LabRoomService {

   

    void save(LabRoom labRoom);

    List<LabRoom> getPaginationWithQuery(LabRoom labRoom, int whichPage, int pageSize);

    /**
     * 总记录数
     * @return
     */
    long totalSize();

    void update(LabRoom labRoom);

    void delete(LabRoom labRoom);

    List<LabRoom> getAll();
}
