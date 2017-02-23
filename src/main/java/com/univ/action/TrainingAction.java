package com.univ.action;

import com.univ.entity.EasyUIPage;
import com.univ.entity.Training;
import com.univ.entity.User;
import com.univ.service.TrainingService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Univ
 * 2017/1/9 21:41
 */
public class TrainingAction extends BaseAction {

    private Training training;

    private List<User> userList;

    private Map jsonMap = new HashMap();

    private List<Training> trainingList;

    @Autowired
    private TrainingService trainingService;


    /**
     * 重点：这里切不可在training与user之间使casacade=save-update,
     * 因为此时的user是通过下拉框传递的，只有id值，如果为save-update，那么user将被更新为null.
     *
     * 小结：通过下拉框建立的多对一关系，不能使用casacade=save-update
     * @return
     */
    public String save() {
        if (null == training.getUser().getId()) {
            training.setUser(null);
        }
        trainingService.save(training);
        jsonMap.put("result", "success");
        return "dml";
    }

    /**
     * 注意，前台处理成training的Director永远不会为null
     * @return
     */
    public String update() {
        if (null == training.getUser().getId()) {
            training.setUser(null);
        }
        trainingService.update(training);
        jsonMap.put("result", "success");
        return "dml";
    }

    public String delete() {
        trainingService.delete(training);
        jsonMap.put("result", "success");
        return "dml";
    }

    public String toList(){
        return "toList";
    }

    public String list(){
        EasyUIPage easyUIPage = getEasyUIPage();
        trainingList = trainingService.getPaginationWithQuery(training, easyUIPage);

        //将数据转换成带有分页功能的datagrid所需的格式
        long total = trainingService.totalSize();
        jsonMap = new HashMap();
        jsonMap.put("total", total);
        jsonMap.put("rows", trainingList);

        return "dataGrid";
    }

    public String getAll(){
        trainingList = trainingService.getAll();
        return "getAll";
    }

    public String verify(){
        training = trainingService.getById(training.getId());
        training.setWasVerified(true);//审核通过
        trainingService.update(training);
        return "dml";
    }

    public Training getTraining() {
        return training;
    }

    public void setTraining(Training training) {
        this.training = training;
    }

    public List<User> getUserList() {
        return userList;
    }

    public void setUserList(List<User> userList) {
        this.userList = userList;
    }

    public Map getJsonMap() {
        return jsonMap;
    }

    public void setJsonMap(Map jsonMap) {
        this.jsonMap = jsonMap;
    }

    public List<Training> getTrainingList() {
        return trainingList;
    }

    public void setTrainingList(List<Training> trainingList) {
        this.trainingList = trainingList;
    }
}
