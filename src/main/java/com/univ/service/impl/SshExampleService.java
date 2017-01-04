package com.univ.service.impl;

import com.univ.dao.ISshExampleDao;
import com.univ.entity.SshExampleEntity;
import com.univ.service.ISshExampleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * created by Univ
 * 16/5/19 16:44
 */
@Service
public class SshExampleService implements ISshExampleService {

	@Autowired
    private ISshExampleDao sshExampleDao;

    public void save(SshExampleEntity category) {
        sshExampleDao.save(category);
    }

    public List<SshExampleEntity> getAll() {
        return sshExampleDao.getAll();
    }

	public SshExampleEntity load(Long id) {
		return sshExampleDao.load(SshExampleEntity.class,id);
	}

	public SshExampleEntity get(Long id) {
		return sshExampleDao.get(SshExampleEntity.class,id);
	}

	public void update(SshExampleEntity category) {
		sshExampleDao.update(category);
	}

	public void delete(SshExampleEntity category) {
		sshExampleDao.delete(category);
	}
}
