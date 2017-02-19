package com.univ.action;

import com.univ.entity.EasyUIPage;
import com.univ.entity.Menu;
import com.univ.entity.Role;
import com.univ.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Univ
 * 2017/1/10 16:57
 */
public class RoleAction extends BaseAction {

    @Autowired
    private RoleService roleService;
    
    private Role role;
    
    private List<Role> roleList;

    private Map jsonMap = new HashMap();

    public String save() {
        roleService.save(role);
        jsonMap.put("result", "success");
        return "dml";
    }

    public String update() {
        roleService.update(role);
        jsonMap.put("result", "success");
        return "dml";
    }

    public String delete() {
        roleService.delete(role);
        jsonMap.put("result", "success");
        return "dml";
    }

    public String toList(){
        return "toList";
    }

    public String list(){
        EasyUIPage easyUIPage = getEasyUIPage();
        roleList = roleService.getPaginationWithQuery(role,easyUIPage);

        //将数据转换成带有分页功能的datagrid所需的格式
        long total = roleService.totalSize();
        jsonMap = new HashMap();
        jsonMap.put("total", total);
        jsonMap.put("rows", roleList);

        return "dataGrid";
    }

    public String getAll(){
        roleList = roleService.getAll();
        return "getAll";
    }

    public String roleManager(){

        //1. 获取此角色role已经关联的所有的功能菜单menu
        String idStrsTemp = request.getParameter("idStrs");
        String[] idStrs = null;

        if(!idStrsTemp.equals("")){
            idStrs = idStrsTemp.split(",");
        }
        for (int i = 0; idStrs  != null && i < idStrs.length;i++) {
            Menu menu = new Menu();
            menu.setId(Long.parseLong(idStrs[i]));
            role.getMenuSet().add(menu);
        }
        roleService.update(role);
        jsonMap.put("result", "success");
        return "dml";
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public List<Role> getRoleList() {
        return roleList;
    }

    public void setRoleList(List<Role> roleList) {
        this.roleList = roleList;
    }

    public Map getJsonMap() {
        return jsonMap;
    }

    public void setJsonMap(Map jsonMap) {
        this.jsonMap = jsonMap;
    }
}
