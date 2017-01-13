package com.univ.action;

import com.opensymphony.xwork2.ActionSupport;
import com.univ.entity.LabRoom;
import com.univ.entity.User;
import com.univ.service.LabRoomService;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Univ
 * 2017/1/9 21:41
 */
public class LabRoomAction extends ActionSupport {

    private LabRoom labRoom;

    private List<User> directorList;

    private Map jsonMap = new HashMap();

    private List<LabRoom> labRoomList;

    @Autowired
    private LabRoomService labRoomService;


    /**
     * 重点：这里切不可在labRoom与user之间使casacade=save-update,
     * 因为此时的user是通过下拉框传递的，只有id值，如果为save-update，那么user将被更新为null.
     *
     * 小结：通过下拉框建立的多对一关系，不能使用casacade=save-update
     * @return
     */
    public String save() {
        if (null == labRoom.getDirector().getId()) {
            labRoom.setDirector(null);
        }
        labRoomService.save(labRoom);
        jsonMap.put("result", "success");
        return "dml";
    }

    /**
     * 注意，前台处理成labRoom的Director永远不会为null
     * @return
     */
    public String update() {
        if (null == labRoom.getDirector().getId()) {
            labRoom.setDirector(null);
        }
        labRoomService.update(labRoom);
        jsonMap.put("result", "success");
        return "dml";
    }

    public String delete() {
        labRoomService.delete(labRoom);
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


        labRoomList = labRoomService.getPaginationWithQuery(labRoom, whichPage, pageSize);
        //将数据转换成带有分页功能的datagrid所需的格式

        long total = labRoomService.totalSize();
        jsonMap = new HashMap();
        jsonMap.put("total", total);
        jsonMap.put("rows", labRoomList);

        return "dataGrid";
    }

    public String getAll(){
        labRoomList = labRoomService.getAll();
        return "getAll";
    }

    public LabRoom getLabRoom() {
        return labRoom;
    }

    public void setLabRoom(LabRoom labRoom) {
        this.labRoom = labRoom;
    }

    public List<User> getDirectorList() {
        return directorList;
    }

    public void setDirectorList(List<User> directorList) {
        this.directorList = directorList;
    }

    public Map getJsonMap() {
        return jsonMap;
    }

    public void setJsonMap(Map jsonMap) {
        this.jsonMap = jsonMap;
    }

    public List<LabRoom> getLabRoomList() {
        return labRoomList;
    }

    public void setLabRoomList(List<LabRoom> labRoomList) {
        this.labRoomList = labRoomList;
    }
}
