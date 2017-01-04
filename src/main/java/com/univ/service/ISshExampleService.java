package com.univ.service;

import com.univ.entity.SshExampleEntity;

import java.util.List;

/**
 * Created by Univ on 16/5/19.
 */
public interface ISshExampleService {
    void save(SshExampleEntity category);

    List<SshExampleEntity> getAll();
    
	SshExampleEntity get(Long id);

	void update(SshExampleEntity category);

	void delete(SshExampleEntity category);
}
