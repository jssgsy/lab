package com.univ.action;

import com.opensymphony.xwork2.ActionSupport;
import com.univ.entity.College;
import com.univ.entity.EasyUIPage;
import com.univ.service.CollegeService;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Univ
 * 2017/1/10 20:45
 */
public class CollegeAction extends BaseAction {

    @Autowired
    private CollegeService collegeService;

    private College college;
    
    private List<College> collegeList;

    private Map jsonMap = new HashMap();

    public String save() {
        if (null == college.getDean().getId()) {
            college.setDean(null);
        }

        if (null == college.getUniversity().getId()) {
            college.setUniversity(null);
        }
        collegeService.save(college);
        jsonMap.put("result", "success");
        return "dml";
    }

    public String update() {
        if (null == college.getDean().getId()) {
            college.setDean(null);
        }

        if (null == college.getUniversity().getId()) {
            college.setUniversity(null);
        }
        collegeService.update(college);
        jsonMap.put("result", "success");
        return "dml";
    }

    public String delete() {
        collegeService.delete(college);
        jsonMap.put("result", "success");
        return "dml";
    }

    public String toList(){
        return "toList";
    }

    public String list(){
        EasyUIPage easyUIPage = getEasyUIPage();
        collegeList = collegeService.getPaginationWithQuery(college, easyUIPage);
        //将数据转换成带有分页功能的datagrid所需的格式

        long total = collegeService.totalSize();
        jsonMap = new HashMap();
        jsonMap.put("total", total);
        jsonMap.put("rows", collegeList);

        return "dataGrid";
    }

    public College getCollege() {
        return college;
    }

    public void setCollege(College college) {
        this.college = college;
    }

    public List<College> getCollegeList() {
        return collegeList;
    }

    public void setCollegeList(List<College> collegeList) {
        this.collegeList = collegeList;
    }

    public Map getJsonMap() {
        return jsonMap;
    }

    public void setJsonMap(Map jsonMap) {
        this.jsonMap = jsonMap;
    }
}
