package com.univ.action;

import com.opensymphony.xwork2.ActionSupport;
import com.univ.entity.AcademicPaper;
import com.univ.entity.User;
import com.univ.service.AcademicPaperService;
import com.univ.service.academicPaperService;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Univ
 * 2017/1/11 21:02
 */
public class AcademicAciton extends ActionSupport {
    
    private AcademicPaper paper;

    private List<AcademicPaper> paperList;

    private List<User> authorList;

    private Map jsonMap = new HashMap();

    @Autowired
    private AcademicPaperService academicPaperService;


    public String save() {
        if (null == paper.getAuthor().getId()) {
            paper.setAuthor(null);
        }
        academicPaperService.save(paper);
        jsonMap.put("result", "success");
        return "dml";
    }


    public String update() {
        if (null == paper.getAuthor().getId()) {
            paper.setAuthor(null);
        }
        academicPaperService.update(paper);
        jsonMap.put("result", "success");
        return "dml";
    }

    public String delete() {
        academicPaperService.delete(paper);
        jsonMap.put("result", "success");
        return "dml";
    }

    public String toList(){
        return "toList";
    }

    public String list(){
        int page = Integer.parseInt(ServletActionContext.getRequest().getParameter("page"));
        int rows = Integer.parseInt(ServletActionContext.getRequest().getParameter("rows"));
        int whichPage = (page-1)*rows;
        int pageSize = rows;


        paperList = academicPaperService.getPaginationWithQuery(paper, whichPage, pageSize);
        //将数据转换成带有分页功能的datagrid所需的格式

        long total = academicPaperService.totalSize();
        jsonMap = new HashMap();
        jsonMap.put("total", total);
        jsonMap.put("rows", paperList);

        return "dataGrid";
    }

}
