package com.univ.action;

import com.opensymphony.xwork2.ActionSupport;
import com.univ.entity.EasyUITreeNode;
import com.univ.entity.Menu;
import com.univ.service.MenuService;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Univ
 * 2017/1/6 15:52
 */
public class MenuAction extends ActionSupport{


    @Autowired
    private MenuService menuService;
    private List<Menu> menuList;
    private  List<EasyUITreeNode> tree; //序列化成json传给EasyUI tree
    private Map jsonMsg = new HashMap();//序列化成json传给前台

    private Menu menu;

    //使用异步加载
    public String getMenuTree(){
        tree = new ArrayList<EasyUITreeNode>();
        //获取前台树节点的id值
        String id = ServletActionContext.getRequest().getParameter("id");

        if(id == null){//说明树是初次加载
            menuList = menuService.getTopMenus();//1.获取根节点
            for (Menu menu : menuList) {
                EasyUITreeNode node = new EasyUITreeNode();
                //2.映射根节点
                node.setId(menu.getId());
                node.setText(menu.getName());
                Map<String, Object> attributes = node.getAttributes();
                attributes.put("url", menu.getUrl());
                attributes.put("px", menu.getPx());
                attributes.put("parent", menu.getParent());

                //根结点需要关闭，不论是否有子结点(一般都会有)
                node.setState("closed");

                tree.add(node);
            }
           
        }else {
            menuList = menuService.getChildrenById(Long.parseLong(id));
            for (Menu menu : menuList) {
                EasyUITreeNode childNode = new EasyUITreeNode();//位置很重要
                //2.映射节点
                childNode.setId(menu.getId());
                childNode.setText(menu.getName());
                Map<String, Object> attributes = childNode.getAttributes();
                attributes.put("url", menu.getUrl());
                attributes.put("px", menu.getPx());
                attributes.put("parent", menu.getParent());

                if (menuService.hasChildren(Long.parseLong(id))) {//有子结点则设置为关闭
                    childNode.setState("closed");
                }

                tree.add(childNode);
            }
        }
        return "easyUiTree";
    }

    public String getAll(){
        menuList =  menuService.getAll();
        return "getAll";
    }

    public String update(){
        //不可少，仔细体会，当前台没有传parent.id时menu的parent.id为null，此时保存时报瞬时对象的错误
        if (menu.getParent().getId() == null) {
            menu.setParent(null);
        }
        try{
            menuService.update(menu);
            jsonMsg.put("result", "success");
        }catch (Exception exception){
            exception.printStackTrace();
            jsonMsg.put("result", "fail");
        }
        return "update";
    }

    /**
     * 作页面跳转使用
     * @return
     */
    public String toList(){
        return "list";
    }

    public List<EasyUITreeNode> getTree() {
        return tree;
    }

    public void setTree(List<EasyUITreeNode> tree) {
        this.tree = tree;
    }

    public List<Menu> getMenuList() {
        return menuList;
    }

    public void setMenuList(List<Menu> menuList) {
        this.menuList = menuList;
    }

    public Menu getMenu() {
        return menu;
    }

    public void setMenu(Menu menu) {
        this.menu = menu;
    }

    public Map getJsonMsg() {
        return jsonMsg;
    }

    public void setJsonMsg(Map jsonMsg) {
        this.jsonMsg = jsonMsg;
    }
}






