package com.univ.action;

import com.opensymphony.xwork2.ActionContext;
import com.univ.entity.EasyUITreeNode;
import com.univ.entity.Menu;
import com.univ.entity.User;
import com.univ.service.IUserService;
import com.univ.service.MenuService;
import com.univ.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.*;

/**
 * Univ
 * 2017/1/6 15:52
 */
public class MenuAction extends BaseAction{

    @Autowired
    private MenuService menuService;

    @Autowired
    private RoleService roleService;

    @Autowired
    private IUserService userService;

    private List<Menu> menuList;
    private  List<EasyUITreeNode> tree; //序列化成json传给EasyUI tree
    private Map jsonMsg = new HashMap();//序列化成json传给前台

    private Menu menu;

    //使用一次性加载，todo:注意只能处理两级的层级关系
    public String getMenuTree(){
        //获取当前用户
        User tempUser = (User) ActionContext.getContext().getSession().get("currentUser");
        User currentUser = userService.find(tempUser.getUsername(),tempUser.getPassword());

        //获取当前用户对应角色拥有的权限(即功能菜单menu)
        Set<Menu> menuSet = currentUser.getRole().getMenuSet();
        Set<Long> menuSetIds = new HashSet<Long>();
        for (Menu m : menuSet) {
            menuSetIds.add(m.getId());
        }

        tree = new ArrayList<EasyUITreeNode>();
        menuList = menuService.getTopMenus();
        for (Menu menu : menuList) {

            if( menuSetIds.contains(menu.getId()) ){
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
                        if (menuSetIds.contains(child.getId())) {//此权限(menu)在当前用户所属角色拥有的权限
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
                }
                tree.add(node);
            }

        }

        return "easyUiTree";
    }

    //使用一次性加载，这里可以让已经关联的角色被选中，todo:注意只能处理两级的层级关系
    public String getMenuTree1(){
        Long roleId = Long.parseLong(request.getParameter("roleId"));
        Set<Menu> linkedMenus = roleService.getLinkedMenus(roleId);//和id为roleId的角色已经关联的菜单menu
        Set<Long> linkedMenuIds = new HashSet<Long>();
        for(Menu temp : linkedMenus){
            linkedMenuIds.add(temp.getId());
        }

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

            if (linkedMenuIds.contains(menu.getId())) {
                node.setChecked(true);
            }

            if (menuService.hasChildren(menu.getId())) {
                List<Menu> children = menuService.getChildrenById(menu.getId());
                for (Menu child : children) {
                    EasyUITreeNode childNode = new EasyUITreeNode();
                    //2.映射子节点
                    childNode.setId(child.getId());
                    childNode.setText(child.getName());

                    //设置此结点是否需要被选中
                    if (linkedMenuIds.contains(child.getId())) {
                        childNode.setChecked(true);
                    }

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
        menuService.delete(menu);
        jsonMsg.put("result", "success");
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






