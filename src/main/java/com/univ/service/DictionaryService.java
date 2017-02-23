package com.univ.service;

import com.univ.entity.Dictionary;

import java.util.List;

/**
 * Created by Univ on 2017/1/6.
 */
public interface DictionaryService {

    /**
     * 返回数据类型
     * @return
     */
    List<Dictionary> getTopDictionaries(String name);

    /**
     * 获取直接具体的数据项
     * @param id
     * @return
     */
    List<Dictionary> getChildrenById(Long id);

    /**
     * 是否有子结点
     * @param id
     * @return
     */
    boolean hasChildren(Long id);

    /**
     * 获取所有的数据字典项
     * @return
     */
    List<Dictionary> getAll();

    /**
     * dictionary
     * @param dictionary
     */
    void update(Dictionary dictionary);

    /**
     * 保存dictionary到数据库中
     * @param dictionary
     */
    void save(Dictionary dictionary);

    /**
     * dictionary
     * @param dictionary
     */
    void delete(Dictionary dictionary);

    Dictionary getById(Long id);
}
