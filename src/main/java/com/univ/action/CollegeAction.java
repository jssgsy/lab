package com.univ.action;

import com.opensymphony.xwork2.ActionSupport;
import com.univ.entity.College;
import com.univ.entity.University;
import com.univ.entity.User;
import com.univ.service.CollegeService;
import com.univ.service.IUserService;
import com.univ.service.UniversityService;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Univ
 * 2017/1/10 20:45
 */
public class CollegeAction extends ActionSupport {

    @Autowired
    private CollegeService collegeService;

    @Autowired
    private IUserService userService;

    //todo:不用导入，可以直接请求对应的action
    @Autowired
    private UniversityService universityService;
    
    private List<User> deanList;//院长
    
    private List<University> universityList;//所属学校
    
    private College college;
    
    private List<College> collegeList;

    private Map jsonMap = new HashMap();


    public String getUser(){
        deanList = userService.getAll();
        return "getUser";
    }

    public String getUniversity(){
        universityList = universityService.getAll();
        return "getUniversity";
    }

    public String save() {
        if (null == college.getDean() || null == college.getDean().getId()) {
            college.setDean(null);
        }

        if (null == college.getUniversity() || null == college.getUniversity().getId()) {
            college.setUniversity(null);
        }
        collegeService.save(college);
        jsonMap.put("result", "success");
        return "dml";
    }

    public String update() {
        if (null == college.getDean() || null == college.getDean().getId()) {
            college.setDean(null);
        }

        if (null == college.getUniversity() || null == college.getUniversity().getId()) {
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

    //todo：可以考虑将分页优化一下
    public String list(){
        int page = Integer.parseInt(ServletActionContext.getRequest().getParameter("page"));
        int rows = Integer.parseInt(ServletActionContext.getRequest().getParameter("rows"));
        int whichPage = (page-1)*rows;
        int pageSize = rows;


        collegeList = collegeService.getPaginationWithQuery(college, whichPage, pageSize);
        //将数据转换成带有分页功能的datagrid所需的格式

        long total = collegeService.totalSize();
        jsonMap = new HashMap();
        jsonMap.put("total", total);
        jsonMap.put("rows", collegeList);

        return "dataGrid";
    }

    public UniversityService getUniversityService() {
        return universityService;
    }

    public void setUniversityService(UniversityService universityService) {
        this.universityService = universityService;
    }

    public List<User> getDeanList() {
        return deanList;
    }

    public void setDeanList(List<User> deanList) {
        this.deanList = deanList;
    }

    public List<University> getUniversityList() {
        return universityList;
    }

    public void setUniversityList(List<University> universityList) {
        this.universityList = universityList;
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
