<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="/WEB-INF/reuse/path.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>

<table id="collegeGrid"></table>

<!-- 查询工具条 -->
<div id="college_search">
    学院名: <input id="college_search_name" name="labRoom.name" style="width:100px;">
    <a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchLabRoom()" style="width:60px">搜索</a><br/>
    <a class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="add_dialog()" style="width:60px">新增</a>
    <a class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="update_dialog()" style="width:60px">修改</a>
    <a class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="del_dialog()" style="width:60px">删除</a>
</div>

<!-- 新增数据字典窗口,这里直接使用样式设置display=none(不初始化为easyui的dialog，当学院点击的时候才生成dialog),减少负荷-->
<div id="addCollege_dialog" style="display: none;">
    <form id="addCollge_form" method="post">
        <table style="text-align: right;padding: 5px 5px;">
            <tr>
                <!-- 将文本和input标签放在不同的td中，有助于施加样式，如上面设置将文本向右对齐 -->
                <td>名称:</td>
                <td><input id="college_name_add" name="college.name" class="easyui-textbox" data-options="required:true" style="width:172px;"></td>
            </tr>

            <tr>
                <td>院长:</td>
                <td><input id="college_dean_add" name="college.dean.id" style="width:172px;"></td>
            </tr>

            <tr>
                <td>所属学校:</td>
                <td><input id="college_university_add" name="college.university.id" style="width:172px;"></td>
            </tr>



        </table>
        <!-- 下面是保存和取消操作（取消操作直接写在这里） -->
        <div style="text-align: center;margin-top: 20px;">
            <a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="addCollege()">保存</a>
            <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel',onClick:function(){$('#addCollege_dialog').dialog('close');}">取消</a>
        </div>
    </form>
</div>

<div id="updateCollege_dialog" style="display: none;">
    <form id="updateCollege_form" method="post">
        <table style="text-align: right;padding: 5px 5px;">
            <tr>
                <td>学院名称:</td>
                <td>
                    <input id="college_name_update" name="college.name" class="easyui-textbox" data-options="required:true" style="width:172px;">
                    <input type="hidden" id="college_id_update" name="college.id">
                </td>
            </tr>

            <tr>
                <td>院长:</td>
                <td><input id="college_dean_update" name="college.dean.id" style="width:172px;"></td>
            </tr>

            <tr>
                <td>所属学校:</td>
                <td><input id="college_university_update" name="college.university.id" style="width:172px;"></td>
            </tr>


        </table>
        <!-- 下面是保存和取消操作（取消操作直接写在这里） -->
        <div style="text-align: center;margin-top: 20px;">
            <a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="updateLabRoom()">保存</a>
            <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel',onClick:function(){$('#updateCollege_dialog').dialog('close');}">取消</a>
        </div>
    </form>
</div>


<script type="text/javascript">

    $("#collegeGrid").datagrid({
        title:'学院管理',
        pagination:true,
        singleSelect:true,
        rownumbers:true,
        fit:true,//此时当点击最外围的layout时整个表格可以自动适应大小
        toolbar:'#college_search',
        url:'<%=path%>/json/collegeAction!list',
        columns: [[
            {field: 'name', title: '学院名称'},
            {
                field: 'dean', title: '院长',
                formatter: function (value, row, index) {
                    if (row.dean) {
                        return row.dean.username;
                    } else {
                        return value;
                    }
                }
            },
            {
                field: 'university', title: '所属学校',
                formatter: function (value, row, index) {
                    if (row.university) {
                        return row.university.name;
                    } else {
                        return value;
                    }
                }
            }
        ]],
        queryParams: {//和查询时发送的请求保持一致
            'college.name': '',
        }
    });



    //查询框中的学院名查询
    $("#college_search_name").textbox({
        icons: [{
            iconCls:'icon-clear',
            handler: function(e){
                $(e.data.target).textbox('clear');
            }
        }]
    });



    //查询数据字典
    function searchLabRoom(){
        $("#collegeGrid").datagrid('load',{
            'college.name':$("#college_search_name").textbox('getValue'),
        });
    }

    //打开新增窗口
    function add_dialog(){
        $("#addCollege_dialog").css("display","block");

        $("#college_dean_add").combobox({
            url:'<%=path%>/json/collegeAction!getUser',
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

        $("#college_university_add").combobox({
            url:'<%=path%>/json/collegeAction!getUniversity',
            valueField:'id',
            textField:'name',
            editable:false,
            icons:[{
                iconCls:'icon-clear',
                handler:function(e){
                    $(e.data.target).combobox('clear');
                }
            }]
        });

        $("#addCollege_dialog").dialog({
            title:'新增学院项',
            width:400,
            height:300,
            modal:true
        });
    }

    //真正执行保存操作
    function addCollege(){
        $("#addCollge_form").form('submit',{
            url:'<%=path%>/json/collegeAction!save',
            success:function(data){
                var data = eval('(' + data + ')');
                //如果新增成功，做三件事：1.刷新链表，2.提示新增操作成功,3.关闭新增窗口
                if(data.result == 'success'){
                    $.messager.alert('新增学院','新增成功。');
                    $("#collegeGrid").datagrid('reload');
                }else{
                    $.messager.alert('新增学院','新增失败。');
                }
                $("#addCollege_dialog").dialog('close');
            }
        });
    }


    //打开修改数据字典
    function update_dialog(){

        $("#college_dean_update").combobox({
            url:'<%=path%>/json/collegeAction!getUser',
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

        $("#college_university_update").combobox({
            url:'<%=path%>/json/collegeAction!getUniversity',
            valueField:'id',
            textField:'name',
            editable:false,
            icons:[{
                iconCls:'icon-clear',
                handler:function(e){
                    $(e.data.target).combobox('clear');
                }
            }]
        });

        var row = $("#collegeGrid").datagrid('getSelected');
        if (row == null) {
            $.messager.alert("修改数据字典项",'请先选中需要修改的项。','info');
            return false;
        }

        //给id赋值便于传递到后台
        $("#college_id_update").val(row.id);

        $("#updateCollege_dialog").css("display","block");

        $("#updateCollege_dialog").dialog({
            title:'修改学院信息',
            width:400,
            height:300,
            modal:true
        });
        //给各字段赋值
        $("#college_name_update").textbox('setValue',row.name);
        $("#college_dean_update").textbox('setValue', row.dean.id);
        $("#college_university_update").combobox('setValue', row.university.id);
    }


    //真正执行更新操作
    function updateLabRoom(){
        $("#updateCollege_form").form('submit',{
            url:'<%=path%>/json/collegeAction!update',
            success:function(data){
                var data = eval('(' + data + ')');
                //如果更新成功，做三件事：1.刷新链表，2.提示新增操作成功,3.关闭新增窗口
                if (data.result == 'success') {
                    $.messager.alert('修改学院','修改成功。');
                    $("#collegeGrid").datagrid('reload');
                } else {
                    $.messager.alert('修改学院','修改失败。');
                }
                $("#updateCollege_dialog").dialog('close');
            }
        });
    }

    //删除
    function del_dialog(){
        var row = $("#collegeGrid").datagrid('getSelected');
        if (row == null) {
            $.messager.alert("删除学院",'请先选中需要删除的项。','info');
            return false;
        }
        $.messager.confirm('删除学院',"确定删除此条记录吗?",function(flag){
            if(flag){
                var id = row.id;
                $.ajax({
                    url:'<%=path%>/json/collegeAction!delete',
                    type:'post',
                    dataType:'json',
                    data:{
                        'college.id':row.id
                    },
                    success:function(data){
                        if(data.result == 'success'){
                            $.messager.alert('删除学院','删除成功。');
                            $("#collegeGrid").datagrid('reload');
                        }else{
                            $.messager.alert('删除学院','删除失败。');
                        }
                    }
                });
            }
        });
    }

</script>

</body>




</html>