package com.univ.action;

import com.opensymphony.xwork2.ActionSupport;
import com.univ.entity.AcademicPaper;
import com.univ.entity.User;
import com.univ.service.AcademicPaperService;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Univ
 * 2017/1/11 21:02
 */
public class AcademicPaperAciton extends ActionSupport {
    
    private AcademicPaper paper;

    private List<AcademicPaper> paperList;

    private Map jsonMap = new HashMap();

    @Autowired
    private AcademicPaperService academicPaperService;


    public String save() {
        String[] ids = ServletActionContext.getRequest().getParameterValues("authorIds");
        for (int i = 0; i < ids.length;i++) {
            User author = new User();
            author.setId(Long.parseLong(ids[i]));
            paper.getAuthorList().add(author);
        }
        academicPaperService.save(paper);
        jsonMap.put("result", "success");
        return "dml";
    }


    public String update() {
        String[] ids = ServletActionContext.getRequest().getParameterValues("authorIds");
        for (int i = 0; i < ids.length;i++) {
            User author = new User();
            author.setId(Long.parseLong(ids[i]));
            paper.getAuthorList().add(author);
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

        long total = academicPaperService.totalSize();
        jsonMap = new HashMap();
        jsonMap.put("total", total);
        jsonMap.put("rows", paperList);

        return "dataGrid";
    }

    public AcademicPaper getPaper() {
        return paper;
    }

    public void setPaper(AcademicPaper paper) {
        this.paper = paper;
    }

    public List<AcademicPaper> getPaperList() {
        return paperList;
    }

    public void setPaperList(List<AcademicPaper> paperList) {
        this.paperList = paperList;
    }

    public Map getJsonMap() {
        return jsonMap;
    }

    public void setJsonMap(Map jsonMap) {
        this.jsonMap = jsonMap;
    }
}
