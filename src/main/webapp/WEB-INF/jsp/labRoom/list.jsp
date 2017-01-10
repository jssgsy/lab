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
    <a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchLabRoom()" style="width:60px">搜索</a><br/>
    <a class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="add_dialog()" style="width:60px">新增</a>
    <a class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="update_dialog()" style="width:60px">修改</a>
    <a class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="del_dialog()" style="width:60px">删除</a>
</div>

<!-- 新增数据字典窗口,这里直接使用样式设置display=none(不初始化为easyui的dialog，当实验室点击的时候才生成dialog),减少负荷-->
<div id="addLabRoom_dialog" style="display: none;">
    <form id="addLabRoom_form" method="post">
        <table style="text-align: right;padding: 5px 5px;">
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
        <!-- 下面是保存和取消操作（取消操作直接写在这里） -->
        <div style="text-align: center;margin-top: 20px;">
            <a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="addLabRoom()">保存</a>
            <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel',onClick:function(){$('#addLabRoom_dialog').dialog('close');}">取消</a>
        </div>
    </form>
</div>

<!-- 修改数据字典窗口,这里直接使用样式设置display=none(不初始化为easyui的dialog，当实验室点击的时候才生成dialog),减少负荷-->
<div id="updateLabRoom_dialog" style="display: none;">
    <form id="updateLabRoom_form" method="post">
        <table style="text-align: right;padding: 5px 5px;">
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
        <!-- 下面是保存和取消操作（取消操作直接写在这里） -->
        <div style="text-align: center;margin-top: 20px;">
            <a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="updateLabRoom()">保存</a>
            <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel',onClick:function(){$('#updateLabRoom_dialog').dialog('close');}">取消</a>
        </div>
    </form>
</div>


<script type="text/javascript">

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



    //查询框中的实验室名查询
    $("#labRoom_search_name").textbox({
        icons: [{
            iconCls:'icon-clear',
            handler: function(e){
                $(e.data.target).textbox('clear');
            }
        }]
    });



    //查询数据字典
    function searchLabRoom(){
        $("#labRoomGrid").datagrid('load',{
            'labRoom.name':$("#labRoom_search_name").textbox('getValue'),
        });
    }

    //打开新增窗口
    function add_dialog(){
        $("#addLabRoom_dialog").css("display","block");

        $("#labRoom_director_add").combobox({
            url:'<%=path%>/json/labRoomAction!getUser',
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
            width:400,
            height:300,
            modal:true
        });
    }

    //真正执行保存操作
    function addLabRoom(){
        $("#addLabRoom_form").form('submit',{
            url:'<%=path%>/json/labRoomAction!save',
            success:function(data){
                var data = eval('(' + data + ')');
                //如果新增成功，做三件事：1.刷新链表，2.提示新增操作成功,3.关闭新增窗口
                if(data.result == 'success'){
                    $.messager.alert('新增实验室','新增成功。');
                    $("#labRoomGrid").datagrid('reload');
                }else{
                    $.messager.alert('新增实验室','新增失败。');
                }
                $("#addLabRoom_dialog").dialog('close');
            }
        });
    }


    //打开修改数据字典
    function update_dialog(){

        $("#labRoom_director_update").combobox({
            url:'<%=path%>/json/labRoomAction!getUser',
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
            width:400,
            height:300,
            modal:true
        });
        //给各字段赋值
        $("#labRoom_name_update").textbox('setValue',row.name);
        $("#labRoom_address_update").textbox('setValue', row.address);
        $("#labRoom_director_update").combobox('setValue', row.director.id);
    }


    //真正执行更新操作
    function updateLabRoom(){
        $("#updateLabRoom_form").form('submit',{
            url:'<%=path%>/json/labRoomAction!update',
            success:function(data){
                var data = eval('(' + data + ')');
                //如果更新成功，做三件事：1.刷新链表，2.提示新增操作成功,3.关闭新增窗口
                if (data.result == 'success') {
                    $.messager.alert('修改实验室','修改成功。');
                    $("#labRoomGrid").datagrid('reload');
                } else {
                    $.messager.alert('修改实验室','修改失败。');
                }
                $("#updateLabRoom_dialog").dialog('close');
            }
        });
    }



    //删除数据字典
    function del_dialog(){
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
                            $.messager.alert('删除实验室','删除成功。');
                            $("#labRoomGrid").datagrid('reload');
                        }else{
                            $.messager.alert('删除实验室','删除失败。');
                        }
                    }
                });
            }
        });
    }




</script>

</body>




</html>