<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="/WEB-INF/reuse/path.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>

<table id="labRoomGrid"></table>

<!-- 查询工具条 -->
<div id="labRoom_search">
    实验室名: <input id="labRoom_search_name" name="labRoom.name" style="width:100px;">
    <a id="labRoom_search_btn">搜索</a><br/>
    <a id="labRoom_add_btn">新增</a>
    <a id="labRoom_update_btn">修改</a>
    <a id="labRoom_remove_btn">删除</a>

</div>

<div id="addLabRoom_dialog" style="display: none;">
    <form id="addLabRoom_form" method="post">
        <table cellspacing="15px" style="text-align: right;padding: 5px 5px;">
            <tr>
                <!-- 将文本和input标签放在不同的td中，有助于施加样式，如上面设置将文本向右对齐 -->
                <td>名称:</td>
                <td><input id="labRoom_name_add" name="labRoom.name" class="easyui-textbox" data-options="required:true" style="width:172px;"></td>
            </tr>
            <tr>
                <td>地址:</td>
                <td>
                    <textarea id="labRoom_address_add" name="labRoom.address" data-options="required:true" class="easyui-textbox" style="width:172px;"></textarea>
                </td>
            </tr>
            <tr>
                <td>负责人:</td>
                <td><input id="labRoom_director_add" name="labRoom.director.id" style="width:172px;"></td>
            </tr>
        </table>

    </form>
</div>

<div id="updateLabRoom_dialog" style="display: none;">
    <form id="updateLabRoom_form" method="post">
        <table cellspacing="15px" style="text-align: right;padding: 5px 5px;">
            <tr>
                <!-- 将文本和input标签放在不同的td中，有助于施加样式，如上面设置将文本向右对齐 -->
                <td>实验室名称:</td>
                <td>
                    <input id="labRoom_name_update" name="labRoom.name" class="easyui-textbox" data-options="required:true" style="width:172px;">
                    <input type="hidden" id="labRoom_id_update" name="labRoom.id">
                </td>
            </tr>
            <tr>
                <td>实验室地址:</td>
                <td><textarea id="labRoom_address_update" name="labRoom.address"  class="easyui-textbox" data-options="required:true" style="width:172px;"></textarea></td>
            </tr>

            <tr>
                <td>负责人:</td>
                <td><input id="labRoom_director_update" name="labRoom.director.id" style="width:172px;"></td>
            </tr>
        </table>

    </form>
</div>

<script type="text/javascript">

    $(function () {

        //根据实验室名查询
        $("#labRoom_search_name").textbox({
            icons: [{
                iconCls:'icon-clear',
                handler: function(e){
                    $(e.data.target).textbox('clear');
                }
            }]
        });

        //查询按钮
        $("#labRoom_search_btn").linkbutton({
            iconCls : 'icon-search',
            onClick : function(){
                $("#labRoomGrid").datagrid('load',{
                    'labRoom.name':$("#labRoom_search_name").textbox('getValue'),
                });
            }
        })

        //新增按钮
        $("#labRoom_add_btn").linkbutton({
            iconCls : 'icon-add',
            onClick : function(){
                $("#addLabRoom_dialog").css("display","block");
                $("#addLabRoom_form").form('clear');

                $("#labRoom_director_add").combobox({
                    url:'<%=path%>/json/userAction!getAll',
                    valueField:'id',
                    textField:'username',
                    editable:false,
                    icons:[{
                        iconCls:'icon-clear',
                        handler:function(e){
                            $(e.data.target).combobox('clear');
                        }
                    }]
                });

                $("#addLabRoom_dialog").dialog({
                    title:'新增实验室项',
                    modal:true,
                    buttons: [{
                        text: '保存',
                        iconCls: 'icon-ok',
                        handler: function () {
                            $("#addLabRoom_form").form('submit',{
                                url:'<%=path%>/json/labRoomAction!save',
                                success:function(data){
                                    var data = eval('(' + data + ')');
                                    //如果新增成功，做三件事：1.刷新链表，2.提示新增操作成功,3.关闭新增窗口
                                    if(data.result == 'success'){
                                        $.messager.show({
                                            title : '新增实验室',
                                            msg : '新增成功!',
                                            timeout : 2000,
                                        });
                                        $("#labRoomGrid").datagrid('reload');
                                    }else{
                                        $.messager.alert('新增实验室','新增失败。');
                                    }
                                    $("#addLabRoom_dialog").dialog('close');
                                }
                            });
                        }
                    }, {
                        text: '取消',
                        iconCls: 'icon-cancel',
                        handler: function () {
                            $('#addLabRoom_dialog').dialog('close');
                        }
                    }],
                });

            }
        })

        //更新按钮
        $("#labRoom_update_btn").linkbutton({
            iconCls : 'icon-edit',
            onClick : function(){
                $("#labRoom_director_update").combobox({
                    url:'<%=path%>/json/userAction!getAll',
                    valueField:'id',
                    textField:'username',
                    editable:false,
                    icons:[{
                        iconCls:'icon-clear',
                        handler:function(e){
                            $(e.data.target).combobox('clear');
                        }
                    }]
                });

                var row = $("#labRoomGrid").datagrid('getSelected');
                if (row == null) {
                    $.messager.alert("修改数据字典项",'请先选中需要修改的项。','info');
                    return false;
                }

                //给id赋值便于传递到后台
                $("#labRoom_id_update").val(row.id);

                $("#updateLabRoom_dialog").css("display","block");

                $("#updateLabRoom_dialog").dialog({
                    title:'修改实验室信息',
                    modal:true,
                    buttons: [{
                        text: '保存',
                        iconCls: 'icon-ok',
                        handler: function () {
                            $("#updateLabRoom_form").form('submit',{
                                url:'<%=path%>/json/labRoomAction!update',
                                success:function(data){
                                    var data = eval('(' + data + ')');
                                    //如果更新成功，做三件事：1.刷新链表，2.提示新增操作成功,3.关闭新增窗口
                                    if (data.result == 'success') {
                                        $.messager.show({
                                            title : '修改实验室',
                                            msg : '修改成功!',
                                            timeout : 2000,
                                        });
                                        $("#labRoomGrid").datagrid('reload');
                                    } else {
                                        $.messager.alert('修改实验室','修改失败。');
                                    }
                                    $("#updateLabRoom_dialog").dialog('close');
                                }
                            })
                        }
                    }, {
                        text: '取消',
                        iconCls: 'icon-cancel',
                        handler: function () {
                            $('#updateLabRoom_dialog').dialog('close');
                        }
                    }],
                });
                //给各字段赋值
                $("#labRoom_name_update").textbox('setValue',row.name);
                $("#labRoom_address_update").textbox('setValue', row.address);
                $("#labRoom_director_update").combobox('setValue', row.director.id);

            }
        })

        //删除按钮
        $("#labRoom_remove_btn").linkbutton({
            iconCls : 'icon-remove',
            onClick : function(){
                var row = $("#labRoomGrid").datagrid('getSelected');
                if (row == null) {
                    $.messager.alert("删除实验室",'请先选中需要删除的项。','info');
                    return false;
                }
                $.messager.confirm('删除实验室',"确定删除此条记录吗?",function(flag){
                    if(flag){
                        var id = row.id;
                        $.ajax({
                            url:'<%=path%>/json/labRoomAction!delete',
                            type:'post',
                            dataType:'json',
                            data:{
                                'labRoom.id':row.id
                            },
                            success:function(data){
                                if(data.result == 'success'){
                                    $.messager.show({
                                        title : '删除实验室',
                                        msg : '删除成功!',
                                        timeout : 2000,
                                    });
                                    $("#labRoomGrid").datagrid('reload');
                                }else{
                                    $.messager.alert('删除实验室','删除失败。');
                                }
                            }
                        });
                    }
                });

            }
        })
    });

    //主体表格
    $("#labRoomGrid").datagrid({
        title:'实验室管理',
        pagination:true,
        singleSelect:true,
        rownumbers:true,
        fit:true,//此时当点击最外围的layout时整个表格可以自动适应大小
        toolbar:'#labRoom_search',
        url:'<%=path%>/json/labRoomAction!list',
        columns: [[
            {field: 'name', title: '实验室名称'},
            {field: 'address', title: '实验室地址'},
            {
                field: 'director', title: '负责人',
                formatter: function (value, row, index) {
                    if (row.director) {
                        return row.director.username;
                    } else {
                        return value;
                    }
                }
            }
        ]],
        queryParams: {//和查询时发送的请求保持一致
            'labRoom.name': '',
        }
    });




</script>

</body>
</html>