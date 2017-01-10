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

    //使用一次性加载，todo:注意只能处理两级的层级关系
    public String getMenuTree(){
        tree = new ArrayList<EasyUITreeNode>();
        menuList = menuService.getTopMenus();
        for (Menu menu : menuList) {
            EasyUITreeNode node = new EasyUITreeNode();
            //2.映射根节点
            node.setId(menu.getId());
            node.setText(menu.getName());
            Map<String, Object> attributes = node.getAttributes();
            attributes.put("px", menu.getPx());
            attributes.put("url", menu.getUrl());
            attributes.put("parent", menu.getParent());
            node.setAttributes(attributes);

            if (menuService.hasChildren(menu.getId())) {
                List<Menu> children = menuService.getChildrenById(menu.getId());
                for (Menu child : children) {
                    EasyUITreeNode childNode = new EasyUITreeNode();
                    //2.映射子节点
                    childNode.setId(child.getId());
                    childNode.setText(child.getName());
                    Map<String, Object> attributes1 = childNode.getAttributes();
                    attributes1.put("px", child.getPx());
                    attributes1.put("url", child.getUrl());
                    attributes1.put("parent", child.getParent());
                    childNode.setAttributes(attributes1);
                    node.getChildren().add(childNode);
                }
            }
            tree.add(node);
        }

        return "easyUiTree";
    }

    public String getAll(){
        menuList =  menuService.getAll();
        return "getAll";
    }

    //todo:当后台操作错误时，此时前台收不到任何信息，需要利用struts2进行异常处理
    public String update(){
        //不可少，仔细体会，当前台没有传parent.id时menu的parent.id为null，此时保存时报瞬时对象的错误
        if (null == menu.getParent().getId()) {
            menu.setParent(null);
        }
        menuService.update(menu);
        jsonMsg.put("result", "success");
        return "dml";//DML,对应insert,update和delete,具体的显示信息由前台控制。
    }

    public String save(){
        //不可少，见update()方法
        if (null == menu.getParent().getId()) {
            menu.setParent(null);
        }
        menuService.save(menu);
        jsonMsg.put("result", "success");
        return "dml";
    }

    public String deleteById(){
        try{
            //todo:研究$.ajax能否传menu.id形式的参数到后台
            Menu m = new Menu();
            //注意，这里不能直接使用属性menu，因为此时menu仍然null
            m.setId(Long.parseLong(ServletActionContext.getRequest().getParameter("id")));
            menuService.delete(m);
            jsonMsg.put("result", "success");
        }catch (Exception exception){
            exception.printStackTrace();
            jsonMsg.put("result", "fail");
        }
        return "dml";
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






