package com.univ.service.impl;

import com.univ.dao.LabRoomDao;
import com.univ.entity.LabRoom;
import com.univ.service.LabRoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Univ
 * 2017/1/9 21:45
 */
@Service
public class LabRoomServiceImpl implements LabRoomService {

    @Autowired
    private LabRoomDao labRoomDao;

    public void save(LabRoom labRoom) {
        labRoomDao.save(labRoom);
    }

    public List<LabRoom> getPaginationWithQuery(LabRoom labRoom, int whichPage, int pageSize) {
        return labRoomDao.getPaginationWithQuery(labRoom,whichPage,pageSize);
    }

    public long totalSize() {
        return labRoomDao.totalSize();
    }

    public void update(LabRoom labRoom) {
        labRoomDao.update(labRoom);
    }

    public void delete(LabRoom labRoom) {
        labRoomDao.delete(labRoom);
    }
}
