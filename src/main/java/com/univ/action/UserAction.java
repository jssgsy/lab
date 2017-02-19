package com.univ.action;

import com.opensymphony.xwork2.ActionContext;
import com.univ.entity.EasyUIPage;
import com.univ.entity.User;
import com.univ.service.IUserService;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Univ
 * 2017/1/4 19:44
 */
public class UserAction extends BaseAction{

    private User user;

    private Map jsonMap = new HashMap();

    private List<User> userList;

    @Autowired
    private IUserService userService;

    public String save(){
        if (null == user.getLabRoom().getId()) {
            user.setLabRoom(null);
        }
        userService.save(user);
        jsonMap.put("result", "success");
        return "dml";
    }

    public String update() {
        if (null == user.getLabRoom().getId()) {
            user.setLabRoom(null);
        }
        userService.update(user);
        jsonMap.put("result", "success");
        return "dml";

    }

    public String delete() {
        userService.delete(user);
        jsonMap.put("result", "success");
        return "dml";
    }


    //todo:已注册时需要返回数据给前台，利用json
    public String regist() {
        if (userService.registered(user.getUsername())) {
            ServletActionContext.getRequest().setAttribute("errorMsg", "此用户已注册!");
            return "error";
        }
        userService.save(user);
        return "login";

    }

    public String toList(){
        return "toList";
    }

    //todo:需要将分页完成的更优雅
    /**
     * 带分页的链表
     * @return
     */
    public String list(){
        EasyUIPage easyUIPage = getEasyUIPage();
        userList = userService.getPaginationWithQuery(user, easyUIPage);

        //将数据转换成带有分页功能的datagrid所需的格式
        long total = userService.totalSize();
        jsonMap = new HashMap();
        jsonMap.put("total", total);
        jsonMap.put("rows", userList);
        return "dataGrid";
    }

    /**
     * 不带分页的链表
     * @return
     */
    public String getAll(){
        userList = userService.getAll();
        return "getAll";
    }

    /*
    todo:可考虑在此使用shiro
    todo:先不考虑密码加密
    用户名和密码非空由页面控制
     */
    public String login() {
        //todo:开发阶段跳过登录,需要时放开下面的注释即可
        if (userService.verified(user)) {//说明此用户已存在，需要注意，这里是将查找到的user放入session中，而不是原生的user,todo:这里其实只需要放入原生user即可，其它需要使用时再去查找数据库
            //将当前用户加入session,注意存入的是硬编码的“currentUser”，便于在前台进行获取
            ActionContext.getContext().getSession().put("currentUser", user);
            return "home";
        }

        return "login";//全局视图
    }

    /**
     * 退出登录
     * @return
     */
    public String logout(){
        //在session中删除当前用户
        ActionContext.getContext().getSession().remove("currentUser");
        return "login";
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Map getJsonMap() {
        return jsonMap;
    }

    public void setJsonMap(Map jsonMap) {
        this.jsonMap = jsonMap;
    }

    public List<User> getUserList() {
        return userList;
    }

    public void setUserList(List<User> userList) {
        this.userList = userList;
    }
}
