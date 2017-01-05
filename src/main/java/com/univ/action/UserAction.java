package com.univ.action;

import com.opensymphony.xwork2.ActionContext;
import com.univ.entity.UserEntity;
import com.univ.service.IUserService;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * Univ
 * 2017/1/4 19:44
 */
public class UserAction {

    private UserEntity user;


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


    /*
    todo:可考虑在此使用shiro
    todo:先不考虑密码加密
    用户名和密码非空由页面控制
     */
    public String login() {
        //todo:开发阶段跳过登录
        if (userService.verified(user)) {
            //加入session
            ActionContext.getContext().getSession().put(user.getUsername(), user);
            return "home";
        }
        return "login";
    }

    public UserEntity getUser() {
        return user;
    }

    public void setUser(UserEntity user) {
        this.user = user;
    }


}
