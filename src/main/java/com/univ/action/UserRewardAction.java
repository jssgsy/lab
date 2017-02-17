package com.univ.action;

import com.univ.entity.EasyUIPage;
import com.univ.entity.UserReward;
import com.univ.service.UserRewardService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Univ
 * 2017/2/17 09:19
 */
public class UserRewardAction extends BaseAction {

    private UserReward userReward;

    private List<UserReward> userRewardList;

    private Map jsonMap = new HashMap();

    @Autowired
    private UserRewardService userRewardService;

    public String save() {
        userRewardService.save(userReward);
        jsonMap.put("result", "success");
        return "dml";
    }


    public String update() {
        userRewardService.update(userReward);
        jsonMap.put("result", "success");
        return "dml";
    }

    public String delete() {
        userRewardService.delete(userReward);
        jsonMap.put("result", "success");
        return "dml";
    }

    public String toList(){
        return "toList";
    }

    public String list(){
        EasyUIPage easyUIPage = getEasyUIPage();
        userRewardList = userRewardService.getPaginationWithQuery(userReward, easyUIPage);
        long total = userRewardService.totalSize();
        jsonMap = new HashMap();
        jsonMap.put("total", total);
        jsonMap.put("rows", userRewardList);
        return "dataGrid";
    }

    public UserReward getUserReward() {
        return userReward;
    }

    public void setUserReward(UserReward userReward) {
        this.userReward = userReward;
    }

    public List<UserReward> getUserRewardList() {
        return userRewardList;
    }

    public void setUserRewardList(List<UserReward> userRewardList) {
        this.userRewardList = userRewardList;
    }

    public Map getJsonMap() {
        return jsonMap;
    }

    public void setJsonMap(Map jsonMap) {
        this.jsonMap = jsonMap;
    }
}
