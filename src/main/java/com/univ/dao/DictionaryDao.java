package com.univ.dao;

import com.univ.entity.Dictionary;

import java.util.List;

/**
 * Created by Univ on 2017/1/6.
 */
public interface DictionaryDao {

    List<Dictionary> getTopDictionarys();

    List<Dictionary> getChildrenById(Long id);

    boolean hasChildren(Long id);

    List<Dictionary> getAll();

    void update(Dictionary dictionary);

    void save(Dictionary dictionary);

    void delete(Dictionary dictionary);
}
