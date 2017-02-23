package com.univ.action;

import com.univ.entity.EasyUIPage;
import com.univ.entity.Monograph;
import com.univ.entity.User;
import com.univ.service.MonographService;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Univ
 * 2017/1/11 21:02
 */
public class MonographAction extends BaseAction {
    
    private Monograph monograph;

    private List<Monograph> monographList;

    private Map jsonMap = new HashMap();

    @Autowired
    private MonographService monographService;


    public String save() {
        String[] ids = ServletActionContext.getRequest().getParameterValues("authorIds");
        for (int i = 0; i < ids.length;i++) {
            User author = new User();
            author.setId(Long.parseLong(ids[i]));
            monograph.getAuthorSet().add(author);
        }
        monographService.save(monograph);
        jsonMap.put("result", "success");
        return "dml";
    }


    public String update() {
        String[] ids = ServletActionContext.getRequest().getParameterValues("authorIds");
        for (int i = 0; i < ids.length;i++) {
            User author = new User();
            author.setId(Long.parseLong(ids[i]));
            monograph.getAuthorSet().add(author);
        }
        monographService.update(monograph);
        jsonMap.put("result", "success");
        return "dml";
    }

    public String delete() {
        monographService.delete(monograph);
        jsonMap.put("result", "success");
        return "dml";
    }

    public String toList(){
        return "toList";
    }

    public String list(){
        EasyUIPage easyUIPage = getEasyUIPage();
        monographList = monographService.getPaginationWithQuery(monograph, easyUIPage);
        long total = monographService.totalSize();
        jsonMap = new HashMap();
        jsonMap.put("total", total);
        jsonMap.put("rows", monographList);
        return "dataGrid";
    }

    public Monograph getMonograph() {
        return monograph;
    }

    public void setMonograph(Monograph monograph) {
        this.monograph = monograph;
    }

    public List<Monograph> getMonographList() {
        return monographList;
    }

    public void setMonographList(List<Monograph> monographList) {
        this.monographList = monographList;
    }

    public Map getJsonMap() {
        return jsonMap;
    }

    public void setJsonMap(Map jsonMap) {
        this.jsonMap = jsonMap;
    }
}
