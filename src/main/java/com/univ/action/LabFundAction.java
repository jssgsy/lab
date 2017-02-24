package com.univ.action;

import com.univ.entity.EasyUIPage;
import com.univ.entity.LabFund;
import com.univ.entity.User;
import com.univ.service.LabFundService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Univ
 * 2017/1/9 21:41
 */
public class LabFundAction extends BaseAction {

    private LabFund labFund;

    private Map jsonMap = new HashMap();

    private List<LabFund> labFundList;

    @Autowired
    private LabFundService labFundService;


    /**
     * 重点：这里切不可在labFund与user之间使casacade=save-update,
     * 因为此时的user是通过下拉框传递的，只有id值，如果为save-update，那么user将被更新为null.
     *
     * 小结：通过下拉框建立的多对一关系，不能使用casacade=save-update
     * @return
     */
    public String save() {
        if (null == labFund.getKeeper().getId()) {
            labFund.setKeeper(null);
        }
        if (null == labFund.getLabRoom().getId()) {
            labFund.setLabRoom(null);
        }
        labFundService.save(labFund);
        jsonMap.put("result", "success");
        return "dml";
    }

    /**
     * 注意，前台处理成labFund的Director永远不会为null
     * @return
     */
    public String update() {
        if (null == labFund.getKeeper().getId()) {
            labFund.setKeeper(null);
        }
        if (null == labFund.getLabRoom().getId()) {
            labFund.setLabRoom(null);
        }
        labFundService.update(labFund);
        jsonMap.put("result", "success");
        return "dml";
    }

    public String delete() {
        labFundService.delete(labFund);
        jsonMap.put("result", "success");
        return "dml";
    }

    public String toList(){
        return "toList";
    }

    public String list(){
        EasyUIPage easyUIPage = getEasyUIPage();
        labFundList = labFundService.getPaginationWithQuery(labFund, easyUIPage);

        //将数据转换成带有分页功能的datagrid所需的格式
        long total = labFundService.totalSize();
        jsonMap = new HashMap();
        jsonMap.put("total", total);
        jsonMap.put("rows", labFundList);

        return "dataGrid";
    }

    public String getAll(){
        labFundList = labFundService.getAll();
        return "getAll";
    }

    public LabFund getLabFund() {
        return labFund;
    }

    public void setLabFund(LabFund labFund) {
        this.labFund = labFund;
    }

    public Map getJsonMap() {
        return jsonMap;
    }

    public void setJsonMap(Map jsonMap) {
        this.jsonMap = jsonMap;
    }

    public List<LabFund> getLabFundList() {
        return labFundList;
    }

    public void setLabFundList(List<LabFund> labFundList) {
        this.labFundList = labFundList;
    }
}
