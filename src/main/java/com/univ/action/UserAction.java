package com.univ.action;

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
public class UserAction {

    private User user;

    private Map dataGridMap;//easyui 的datagrid需要的json数据

    @Autowired
    private IUserService userService;

    public String toUpdate() {
        return null;
    }

    public String update() {
        return null;

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

    //todo:需要将分布完成的更优雅
    public String list(){
        int page = Integer.parseInt(ServletActionContext.getRequest().getParameter("page"));
        int rows = Integer.parseInt(ServletActionContext.getRequest().getParameter("rows"));
        int whichPage = (page-1)*rows;
        int pageSize = rows;


        List<User> userList = userService.getAll(whichPage, pageSize);
        //将数据转换成带有分页功能的datagrid所需的格式
        //todo:这里需要优化一下获得所有记录的hql
        int total = userService.totalSize();
        dataGridMap = new HashMap();
        dataGridMap.put("total", total);
        dataGridMap.put("rows", userList);

        return "dataGrid";
    }

    /*
    todo:可考虑在此使用shiro
    todo:先不考虑密码加密
    用户名和密码非空由页面控制
     */
    public String login() {
        //todo:开发阶段跳过登录,需要时放开下面的注释即可
       /* if (userService.verified(user)) {
            //加入session
            ActionContext.getContext().getSession().put(user.getUsername(), user);
            return "home";
        }
        return "login";*/

        return "home";
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Map getDataGridMap() {
        return dataGridMap;
    }

    public void setDataGridMap(Map dataGridMap) {
        this.dataGridMap = dataGridMap;
    }
}
