package com.univ.action;

import com.univ.entity.Conference;
import com.univ.entity.EasyUIPage;
import com.univ.entity.User;
import com.univ.service.ConferenceService;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Univ
 * 2017/1/11 21:02
 */
public class ConferenceAction extends BaseAction {
    
    private Conference conference;

    private List<Conference> conferenceList;

    private Map jsonMap = new HashMap();

    @Autowired
    private ConferenceService conferenceService;


    public String save() {
        String[] ids = ServletActionContext.getRequest().getParameterValues("participatorIds");
        for (int i = 0; i < ids.length;i++) {
            User author = new User();
            author.setId(Long.parseLong(ids[i]));
            conference.getParticipatorSet().add(author);
        }
        conferenceService.save(conference);
        jsonMap.put("result", "success");
        return "dml";
    }


    public String update() {
        String[] ids = ServletActionContext.getRequest().getParameterValues("participatorIds");
        for (int i = 0; i < ids.length;i++) {
            User author = new User();
            author.setId(Long.parseLong(ids[i]));
            conference.getParticipatorSet().add(author);
        }
        conferenceService.update(conference);
        jsonMap.put("result", "success");
        return "dml";
    }

    public String delete() {
        conferenceService.delete(conference);
        jsonMap.put("result", "success");
        return "dml";
    }

    public String toList(){
        return "toList";
    }

    public String list(){
        EasyUIPage easyUIPage = getEasyUIPage();
        conferenceList = conferenceService.getPaginationWithQuery(conference, easyUIPage);
        long total = conferenceService.totalSize();
        jsonMap = new HashMap();
        jsonMap.put("total", total);
        jsonMap.put("rows", conferenceList);
        return "dataGrid";
    }

    public Conference getConference() {
        return conference;
    }

    public void setConference(Conference conference) {
        this.conference = conference;
    }

    public List<Conference> getConferenceList() {
        return conferenceList;
    }

    public void setConferenceList(List<Conference> conferenceList) {
        this.conferenceList = conferenceList;
    }

    public Map getJsonMap() {
        return jsonMap;
    }

    public void setJsonMap(Map jsonMap) {
        this.jsonMap = jsonMap;
    }
}
