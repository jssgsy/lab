package com.univ.action;

import com.univ.entity.EasyUIPage;
import com.univ.entity.University;
import com.univ.service.UniversityService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Univ
 * 2017/1/10 16:57
 */
public class UniversityAction extends BaseAction {

    @Autowired
    private UniversityService universityService;
    
    private University university;
    
    private List<University> universityList;

    private Map jsonMap = new HashMap();

    //todo:可以将result放到属性文件中
    public String save() {
        universityService.save(university);
        jsonMap.put("result", "success");
        return "dml";
    }

    public String update() {
        universityService.update(university);
        jsonMap.put("result", "success");
        return "dml";
    }

    public String delete() {
        universityService.delete(university);
        jsonMap.put("result", "success");
        return "dml";
    }

    public String toList(){
        return "toList";
    }

    public String list(){
        EasyUIPage easyUIPage = getEasyUIPage();
        universityList = universityService.getPaginationWithQuery(university,easyUIPage);

        //将数据转换成带有分页功能的datagrid所需的格式
        long total = universityService.totalSize();
        jsonMap = new HashMap();
        jsonMap.put("total", total);
        jsonMap.put("rows", universityList);

        return "dataGrid";
    }

    public String getAll(){
        universityList = universityService.getAll();
        return "getAll";
    }

    public University getUniversity() {
        return university;
    }

    public void setUniversity(University university) {
        this.university = university;
    }

    public List<University> getUniversityList() {
        return universityList;
    }

    public void setUniversityList(List<University> universityList) {
        this.universityList = universityList;
    }

    public Map getJsonMap() {
        return jsonMap;
    }

    public void setJsonMap(Map jsonMap) {
        this.jsonMap = jsonMap;
    }
}
