<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="/WEB-INF/reuse/path.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>

<table id="roleGrid"></table>

<!-- 查询工具条 -->
<div id="role_search">
    角色名称: <input id="role_search_name" name="role.name" style="width:100px;">
    <a id="role_search_btn">搜索</a><br/>
    <a id="role_add_btn">新增</a>
    <a id="role_update_btn">修改</a>
    <a id="role_remove_btn">删除</a>
</div>

<!-- 新增窗口,这里直接使用样式设置display=none(不初始化为easyui的dialog，当角色点击的时候才生成dialog),减少负荷-->
<div id="add_Role_dialog" style="display: none;">
    <form id="add_Role_form" method="post">
        <table cellspacing="10px" style="text-align: right;padding: 5px 5px;">
            <tr>
                <td>角色名称:</td>
                <td><input name="role.name" class="easyui-textbox" data-options="required:true" style="width:172px;"></td>
            </tr>

            <tr>
                <td>简介:</td>
                <td>
                    <textarea name="role.remark" rows="10" class="textbox" style="resize:none;width:160px;white-space:pre-wrap;padding: 5px"></textarea>
                </td>
            </tr>
        </table>
    </form>
</div>

<!-- 修改窗口,这里直接使用样式设置display=none(不初始化为easyui的dialog，当角色点击的时候才生成dialog),减少负荷-->
<div id="update_Role_dialog" style="display: none;">
    <form id="update_Role_form" method="post">
        <table cellspacing="10px" style="text-align: right;padding: 5px 5px;">
           
            <tr>
                <td>角色名称:</td>
                <td>
                    <input id="role_name_update" name="role.name" class="easyui-textbox" data-options="required:true" style="width:172px;">
                    <input type="hidden" id="role_id_update" name="role.id">
                </td>
            </tr>
           
            <tr>
                <td>备注:</td>
                <td>
                    <textarea id="role_remark_update" name="role.remark" rows="10" maxlength="120" class="textbox" style="resize:none;width:160px;white-space:pre-wrap;padding: 5px"></textarea>
                </td>
            </tr>
        </table>
    </form>
</div>

<div id="RoleManager_dialog" style="display: none;">
    <ul id="RoleManager_tree" style="margin-top: 10px; margin-bottom: 30px"></ul>
</div>


<script type="text/javascript">

    $(function () {
        //根据角色名称查询
        $("#role_search_name").textbox({
            icons: [{
                iconCls:'icon-clear',
                handler: function(e){
                    $(e.data.target).textbox('clear');
                }
            }]
        });

        //搜索按钮
        $("#role_search_btn").linkbutton({
            iconCls : 'icon-search',
            onClick : function () {
                $("#roleGrid").datagrid('load',{
                    'role.name':$("#role_search_name").textbox('getValue'),
                });
            }
        });

        //新增按钮
        $("#role_add_btn").linkbutton({
            iconCls : 'icon-add',
            onClick : function () {
                $("#add_Role_dialog").css("display","block");

                $("#add_Role_form").form('clear');

                $("#add_Role_dialog").dialog({
                    title:'新增角色项',
                    modal:true,
                    buttons: [{
                        text: '保存',
                        iconCls: 'icon-ok',
                        handler: function () {
                            $("#add_Role_form").form('submit',{
                                url:'<%=path%>/json/roleAction!save',
                                success:function(data){
                                    try{
                                        var res = eval('(' + data + ')');
                                        if(res.result == 'success') {
                                            $.messager.show({
                                                title: '新增角色',
                                                msg: '新增成功!',
                                                timeout: 2000,
                                            });
                                            $("#roleGrid").datagrid('reload');
                                            $("#add_Role_dialog").dialog('close');
                                        }
                                    }catch(err){
                                        $.messager.alert('新增角色',data, 'error');
                                    }
                                }
                            });
                        }
                    }, {
                        text: '取消',
                        iconCls: 'icon-cancel',
                        handler: function () {
                            $('#add_Role_dialog').dialog('close');
                        }
                    }],
                });
            }
        });

        //更新按钮
        $("#role_update_btn").linkbutton({
            iconCls : 'icon-edit',
            onClick : function () {
                var row = $("#roleGrid").datagrid('getSelected');
                if (row == null) {
                    $.messager.alert("修改角色信息",'请先选中需要修改的角色。','info');
                    return false;
                }

                //给id赋值便于传递到后台
                $("#role_id_update").val(row.id);

                $("#update_Role_dialog").css("display","block");

                $("#update_Role_dialog").dialog({
                    title:'修改角色信息',
                    modal:true,
                    buttons: [{
                        text: '保存',
                        iconCls: 'icon-ok',
                        handler: function () {
                            $("#update_Role_form").form('submit',{
                                url:'<%=path%>/json/roleAction!update',
                                success:function(data){
                                    try{
                                        var res = eval('(' + data + ')');
                                        //如果更新成功，做三件事：1.刷新链表，2.提示新增操作成功,3.关闭新增窗口
                                        if (res.result == 'success') {
                                            $.messager.show({
                                                title : '修改角色',
                                                msg : '修改成功!',
                                                timeout : 2000,
                                            });
                                            $("#roleGrid").datagrid('reload');
                                            $("#update_Role_dialog").dialog('close');
                                        }
                                    }catch (err){
                                        $.messager.alert('修改角色',data, 'error');
                                    }
                                }
                            });
                        }
                    }, {
                        text: '取消',
                        iconCls: 'icon-cancel',
                        handler: function () {
                            $('#update_Role_dialog').dialog('close');
                        }
                    }],
                });
                //给各字段赋值
                $("#role_name_update").textbox('setValue',row.name);
                $("#role_remark_update").val(row.remark);
            }
        });

        //删除按钮
        $("#role_remove_btn").linkbutton({
            iconCls : 'icon-remove',
            onClick : function () {
                var row = $("#roleGrid").datagrid('getSelected');
                if (row == null) {
                    $.messager.alert("删除角色",'请先选中需要删除的角色。','info');
                    return false;
                }
                $.messager.confirm('删除角色',"确定删除此条记录吗?",function(flag){
                    if(flag){
                        var id = row.id;
                        $.ajax({
                            url:'<%=path%>/json/roleAction!delete',
                            type:'post',
                            dataType:'json',
                            data:{
                                'role.id':row.id
                            },
                            success:function(data){
                                if(data.result == 'success'){
                                    $.messager.show({
                                        title : '删除角色',
                                        msg : '删除成功!',
                                        timeout : 2000,//停留2秒，默认为4秒
                                    });
                                    $("#roleGrid").datagrid('reload');
                                }else{
                                    $.messager.alert('删除角色','删除失败。');
                                }
                            }
                        });
                    }
                });
            }
        });

        //主体表格
        $("#roleGrid").datagrid({
            title:'角色管理',
            pagination:true,
            singleSelect:true,
            rownumbers:true,
            fit:true,
            toolbar:'#role_search',
            url:'<%=path%>/json/roleAction!list',
            columns: [[
                {field : 'name', title: '角色名称'},
                {field : 'remark', title: '角色简介'},
                {
                    field : '#',title : '操作',
                    formatter : function (value, row, index) {
                        var role = new Object();
                        role.id = row.id;
                        role.name = row.name;
                        role.remark = row.remark;
                        return '<a href="javascript:roleManager(' + index + ')" >权限管理</a>';
                    }
                }
            ]],
            queryParams: {//和查询时发送的请求保持一致
                'role.name': '',
            }
        });
    });


    function roleManager(index) {
        //获取要设置权限的角色对应的行
        var row = $('#roleGrid').datagrid('getData').rows[index];
        $("#RoleManager_dialog").css("display","block");
        $("#RoleManager_tree").tree({
            url:'<%=path%>/json/menuAction!getMenuTree1',
            method:'get',
            queryParams : {
                roleId : row.id,
            },
            lines:true,
            checkbox:true,
            onlyLeafCheck:false,//只有叶子节点才显示复选框
        });

        $("#RoleManager_dialog").dialog({
            title:'角色权限管理',
            width : 272,
            height: 'auto',
            modal:true,
            buttons: [{
                text: '保存',
                iconCls: 'icon-ok',
                handler: function () {
                    //获取选中的结点
                    var nodes = $('#RoleManager_tree').tree('getChecked');

                    //获取所有选中结点的id
                    var idStrs = '';
                    for(var i=0; i<nodes.length; i++){
                        if (idStrs != '') {//将各选中的节点的id以分号隔开，便于在后台解析
                            idStrs += ',';
                        }
                        idStrs += nodes[i].id;
                    }

                    //为角色设置权限
                    $.ajax({
                        url:'<%=path%>/json/roleAction!roleManager',
                        type:'post',
                        dataType:'json',
                        data:{
                            'role.id' : row.id,
                            'role.name' : row.name,
                            'role.remark' : row.remark,
                            'idStrs':idStrs
                        },
                        //todo:这里也需要做异常处理
                        success:function(data){
                            if(data.result == 'success'){
                                $.messager.show({
                                    title : '权限管理',
                                    msg : '设置成功!',
                                    timeout : 2000,//停留2秒，默认为4秒
                                });
                                $("#roleGrid").datagrid('reload');
                                $("#RoleManager_dialog").dialog('close');
                            }else{
                                $.messager.alert('权限管理','设置失败。');
                            }
                        }
                    });

                }
            }, {
                text: '取消',
                iconCls: 'icon-cancel',
                handler: function () {
                    $('#RoleManager_dialog').dialog('close');
                }
            }],
        })




    }
</script>

</body>




</html>