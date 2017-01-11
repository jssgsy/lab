package com.univ.action;

import com.opensymphony.xwork2.ActionSupport;
import com.univ.entity.Dictionary;
import com.univ.entity.EasyUITreeNode;
import com.univ.service.DictionaryService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Univ
 * 2017/1/6 15:52
 */
public class DictionaryAction extends ActionSupport{

    @Autowired
    private DictionaryService dictionaryService;
    private List<Dictionary> dictionaryList;
    private  List<EasyUITreeNode> tree;
    private Map jsonMsg = new HashMap();

    private Dictionary dictionary;

    //一次性全部加载,todo:这里只能处理两级层级关系，需要改善
    public String getDictionaryTree(){
        tree = new ArrayList<EasyUITreeNode>();
        dictionaryList = dictionaryService.getTopDictionarys();
        for (Dictionary dictionary : dictionaryList) {
            EasyUITreeNode node = new EasyUITreeNode();
            //2.映射根节点
            node.setId(dictionary.getId());
            node.setText(dictionary.getName());
            Map<String, Object> attributes = node.getAttributes();
            attributes.put("description", dictionary.getDescription());
            attributes.put("parent", dictionary.getParent());
            node.setAttributes(attributes);

            if (dictionaryService.hasChildren(dictionary.getId())) {
                List<Dictionary> children = dictionaryService.getChildrenById(dictionary.getId());
                for (Dictionary child : children) {
                    EasyUITreeNode childNode = new EasyUITreeNode();
                    //2.映射子节点
                    childNode.setId(child.getId());
                    childNode.setText(child.getName());
                    Map<String, Object> attributes1 = childNode.getAttributes();
                    attributes1.put("description", child.getDescription());
                    attributes1.put("parent", child.getParent());
                    childNode.setAttributes(attributes1);
                    node.getChildren().add(childNode);
                }
            }
            tree.add(node);
        }
        return "easyUiTree";
    }

    public String getAll(){
        dictionaryList =  dictionaryService.getAll();
        return "dictionaryList";
    }

    public String update(){
        if (dictionary.getParent().getId() == null) {
            dictionary.setParent(null);
        }
        dictionaryService.update(dictionary);
        jsonMsg.put("result", "success");
        return "dml";//DML,对应insert,update和delete,具体的显示信息由前台控制。
    }

    public String save(){
        if (dictionary.getParent().getId() == null) {
            dictionary.setParent(null);
        }
        dictionaryService.save(dictionary);
        jsonMsg.put("result", "success");
        return "dml";
    }

    public String deleteById(){
        dictionaryService.delete(dictionary);
        jsonMsg.put("result", "success");
        return "dml";
    }

    public String getTopDictionarys(){
        dictionaryList = dictionaryService.getTopDictionarys();
        return "dictionaryList";
    }

    /**
     * 作页面跳转使用
     * @return
     */
    public String toList(){
        return "list";
    }

    public List<EasyUITreeNode> getTree() {
        return tree;
    }

    public void setTree(List<EasyUITreeNode> tree) {
        this.tree = tree;
    }

    public List<Dictionary> getDictionaryList() {
        return dictionaryList;
    }

    public void setDictionaryList(List<Dictionary> dictionaryList) {
        this.dictionaryList = dictionaryList;
    }

    public Dictionary getDictionary() {
        return dictionary;
    }

    public void setDictionary(Dictionary Dictionary) {
        this.dictionary = Dictionary;
    }

    public Map getJsonMsg() {
        return jsonMsg;
    }

    public void setJsonMsg(Map jsonMsg) {
        this.jsonMsg = jsonMsg;
    }
}






