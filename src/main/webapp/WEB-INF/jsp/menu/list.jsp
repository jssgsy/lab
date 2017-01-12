<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="/WEB-INF/reuse/path.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>

<div class="easyui-layout" style="width:100%;height:100%">
    <div data-options="region:'west',title:'功能树管理'" style="width:200px;">
        <ul id="menu_tree"></ul>
    </div>
    <div data-options="region:'center',title:'详情',tools:'#menu_tool'" style="padding:5px 5px;">
        <div style="width:400px;height:300px;">
            <form id="updateMenu_form" method="post">
                <table cellspacing="15px" style="text-align: right;padding: 5px 5px;">
                    <tr>
                        <td>名称:</td>
                        <td>
                            <input id="menu_name_update" name="menu.name" class="easyui-textbox" data-options="required:true" style="width:172px;">
                            <input type="hidden" id="menu_id_update" name="menu.id">
                        </td>
                    </tr>
                    <tr>
                        <td>url:</td>
                        <td><input id="menu_url_update" name="menu.url" class="easyui-textbox" style="width:172px;"></td>
                    </tr>
                    <tr>
                        <td>排序:</td>
                        <td><input id="menu_px_update" name="px" class="easyui-numberspinner" data-options="prompt:'数字越大,排序越靠后'" style="width:172px;"></td>
                    </tr>
                    <tr>
                        <td>所属菜单:</td>
                        <%--将被做成combobox--%>
                        <td><input id="menu_parent_update" name="menu.parent.id" style="width:172px;"></td>
                    </tr>
                </table>

                <div style="margin-top: 20px;margin-left: 90px;">
                    <a class="easyui-linkbutton" data-options="iconCls:'icon-save'" style="margin: 10px" onclick="updateMenu()">修改</a>
                    <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="delMenu_dialog()">删除</a>
                </div>
            </form>
        </div>
    </div>
    <%--todo:将图标放到layout的左边，并能点击--%>
    <div id="menu_tool">
        <a href="javascript:void(0)" class="icon-add" onclick="addMenu_dialog()"></a>
    </div>

    <!-- 新增菜单项窗口,这里直接使用样式设置display=none(不初始化为easyui的dialog，当用户点击的时候才生成dialog),减少负荷-->
    <div id="addMenu_dialog" style="display: none;">
        <form id="addMenu_form" method="post">
            <table cellspacing="15px" style="text-align: right;padding: 5px 5px;">
                <tr>
                    <!-- 将文本和input标签放在不同的td中，有助于施加样式，如上面设置将文本向右对齐 -->
                    <td>名称:</td>
                    <td><input id="menu_name_add" name="menu.name" class="easyui-textbox" data-options="required:true" style="width:172px;"></td>
                </tr>
                <tr>
                    <td>url:</td>
                    <td><input id="menu_url_add" name="menu.url" class="easyui-textbox" style="width:172px;"></td>
                </tr>
                <tr>
                    <td>排序:</td>
                    <td><input id="menu_px_add" name="menu.px" class="easyui-numberspinner" data-options="prompt:'数字越大,排序越靠后'" style="width:172px;"></td>
                </tr>
                <tr>
                    <td>所属菜单:</td>
                    <td><input id="menu_parent_add" name="menu.parent.id" style="width:172px;"></td>
                </tr>
            </table>

        </form>
    </div>
</div>
<script type="text/javascript">
    $(function(){

        $("#menu_tree").tree({
            url:'<%=path%>/json/menuAction!getMenuTree',
            onClick:function(node){
                $("#menu_name_update").textbox('setValue',node.text);
                $("#menu_id_update").val(node.id);//便于传递到后台作为更新的id
                $("#menu_url_update").textbox('setValue',node.attributes.url);
                $("#menu_px_update").numberspinner('setValue',node.attributes.px);

                if( node.attributes.parent){//点击的是非顶结点
                    $("#menu_parent_update").combotree('enable');//非顶层结点的父结点可修改
                    $("#menu_parent_update").combotree('setValue',node.attributes.parent.id);
                }else {//点击顶结点时清空
                    $("#menu_parent_update").combotree('clear');
                    $("#menu_parent_update").combotree('disable');//不能修改顶层结点的父结点
                }
            }
        });

        //todo:这里可以考虑使用combotree
        //所属菜单
        $("#menu_parent_update").combotree({
            url:'<%=path%>/json/menuAction!getMenuTree',
            valueField:'id',//默认为value
            textField:'name',//默认为text
            editable:false,
            panelHeight:'auto',
            icons:[{
                iconCls:'icon-clear',
                handler:function(e){
                    $(e.data.target).combobox('clear');
                }
            }]
        });
    });

    //打开新增窗口
    function addMenu_dialog(){
        $("#addMenu_dialog").css("display","block");

        $("#addMenu_form").form('clear');

        //所属菜单
        $("#menu_parent_add").combotree({
            url:'<%=path%>/json/menuAction!getMenuTree',
            valueField:'id',
            textField:'name',
            editable:false,
            panelHeight:'auto',
            icons:[{
                iconCls:'icon-clear',
                handler:function(e){
                    $(e.data.target).combobox('clear');
                }
            }]
        });

        $("#addMenu_dialog").dialog({
            title:'新增菜单项',
            width:350,
            modal:true,
            buttons: [{
                text: '保存',
                iconCls: 'icon-ok',
                handler: function () {
                    addMenu();
                }
            }, {
                text: '取消',
                iconCls: 'icon-cancel',
                handler: function () {
                    $('#addMenu_dialog').dialog('close');
                }
            }],
        });
    }

    //真正新增菜单项的场所
    function addMenu(){
        $("#addMenu_form").form('submit',{
            url:'<%=path%>/json/menuAction!save',
            success:function(data){
                var data = eval('(' + data + ')');
                if (data.result == 'success') {
                    $.messager.show({
                        title : '新增菜单项',
                        msg : '新增成功!',
                        timeout : 2000
                    });
                    $("#menu_tree").tree('reload');
                    $("#addMenu_dialog").dialog('close');
                } else {
                    $.messager.alert('新增菜单项','新增失败。');
                    $("#addMenu_dialog").dialog('close');
                }
            }
        });
    }

    //修改菜单项
    function updateMenu(){
        var node = $("#menu_tree").tree('getSelected');
        if (node == null) {
            $.messager.alert("修改菜单项",'请先从树中选中需要更新的菜单项。','info');
            return false;
        }

        $("#menu_parent_update").combobox('enable');//重要，否则dictionary.parent.id将不被当作参数传递，后台报空指针

        $("#updateMenu_form").form('submit',{
            url:'<%=path%>/json/menuAction!update',
            success:function(data){
                var data = eval('(' + data + ')');
                if (data.result == 'success') {
                    $.messager.show({
                        title : '修改菜单项',
                        msg : '修改成功!',
                        timeout : 2000
                    });
                    $("#menu_tree").tree('reload');
                } else {
                    $.messager.alert('修改菜单项','修改失败。');
                }
            }
        });
    }

    //删除菜单项
    function delMenu_dialog(){
        var node = $("#menu_tree").tree('getSelected');
        if (node == null) {
            $.messager.alert("删除菜单项",'请先从树中选中需要删除的菜单项。','info');
            return false;
        }
        if(!$("#menu_tree").tree('isLeaf',node.target)){
            $.messager.alert('删除菜单项','非叶子节点不能删除。','warning');
            return false;
        }
        $.messager.confirm('删除菜单项',"确定删除此条记录吗?",function(flag){
            if(flag){
                var id = node.id;
                $.ajax({
                    url:'<%=path%>/json/menuAction!deleteById',
                    type:'post',
                    dataType:'json',
                    data:{
                        'menu.id' : node.id
                    },
                    success:function(data){
                        if(data.result == 'success'){
                            $.messager.show({
                                title : '删除菜单项',
                                msg : '删除成功!',
                                timeout : 2000
                            });
                            $("#menu_tree").tree('reload');
                        }else{
                            $.messager.alert('删除菜单项','删除失败。');
                        }
                    }
                });
            }
        });
    }
</script>


</body>


</html>