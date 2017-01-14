package com.univ.action;

import com.opensymphony.xwork2.ActionSupport;
import com.univ.entity.EasyUIPage;
import org.apache.struts2.interceptor.ServletRequestAware;

import javax.servlet.http.HttpServletRequest;

/**
 * Univ
 * 2017/1/14 15:15
 */

/**
 * 定义基Action类。
 * 主要用来封装EasyUI的分页与获取request对象。
 */
public class BaseAction extends ActionSupport implements ServletRequestAware {

    //定义成公有的，供子Action不时之需
    public HttpServletRequest request;
    public void setServletRequest(HttpServletRequest request) {
        this.request = request;
    }

    /**
     * 封装EasyUI中datagrid分页的请求参数
     */
    private int page;//对应于datagrid向后台请求数据时发送的请求参数page，表示第几页,默认值为1
    private int rows;//对应于datagrid向后台请求数据时发送的请求参数page，表示一页多少记录，默认值为10

    /**
     * 这里直接将分页参数封装成hql需要的参数，此时dao层中只需要调用如下方法便可实现分页
     *  query.setFirstResult(easyUIPage.getWhichPage());
     *  query.setMaxResults(easyUIPage.getPageSize());
     * @return
     */
    public EasyUIPage getEasyUIPage(){
        return new EasyUIPage((page-1)*rows, rows);
    }

}
