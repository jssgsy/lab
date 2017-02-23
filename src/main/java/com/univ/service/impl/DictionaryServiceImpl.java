package com.univ.service.impl;

import com.univ.dao.DictionaryDao;
import com.univ.entity.Dictionary;
import com.univ.service.DictionaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Univ
 * 2017/1/6 16:00
 */
@Service
public class DictionaryServiceImpl implements DictionaryService {

    @Autowired
    private DictionaryDao dictionaryDao;


    public List<Dictionary> getTopDictionaries(String name) {
        return dictionaryDao.getTopDictionaries(name);
    }

    public List<Dictionary> getChildrenById(Long id) {
        return dictionaryDao.getChildrenById(id);
    }

    public boolean hasChildren(Long id) {
        return dictionaryDao.hasChildren(id);
    }

    public List<Dictionary> getAll() {
        return dictionaryDao.getAll();
    }

    public void update(Dictionary Dictionary) {
        dictionaryDao.update(Dictionary);
    }

    public void save(Dictionary Dictionary) {
        dictionaryDao.save(Dictionary);
    }

    public void delete(Dictionary Dictionary) {
        dictionaryDao.delete(Dictionary);
    }

    public Dictionary getById(Long id) {
        return dictionaryDao.getById(id);
    }
}
