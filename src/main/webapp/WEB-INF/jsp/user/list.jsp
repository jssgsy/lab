<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="/WEB-INF/reuse/path.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>

<table id="userGrid"></table>

<!-- 查询工具条 -->
<div id="search">
    用户名: <input id="username" name="name" style="width:100px;">
    <a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchUser()" style="width:60px">搜索</a><br/>
    <a class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="add_dialog()" style="width:60px">新增</a>
    <a class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="update_dialog()" style="width:60px">修改</a>
    <a class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="del_dialog()" style="width:60px">删除</a>
</div>

<!-- 新增数据字典窗口,这里直接使用样式设置display=none(不初始化为easyui的dialog，当用户点击的时候才生成dialog),减少负荷-->
<div id="addUser_dialog" style="display: none;">
    <form id="addUser_form" method="post">
        <table style="text-align: right;padding: 5px 5px;">
            <tr>
                <!-- 将文本和input标签放在不同的td中，有助于施加样式，如上面设置将文本向右对齐 -->
                <td>用户名:</td>
                <td><input id="name_add" name="user.username" class="easyui-textbox" data-options="required:true" style="width:172px;"></td>
            </tr>
            <tr>
                <td>密码:</td>
                <td>
                    <textarea id="password_add" name="user.password" data-options="required:true" class="easyui-textbox" style="width:172px;"></textarea>
                </td>
            </tr>
            <tr>
                <td>电子邮箱:</td>
                <td>
                    <textarea id="email_add" name="user.email" data-options="required:true" class="easyui-textbox" style="width:172px;"></textarea>
                </td>
            </tr>
            <tr>
                <td>手机号码:</td>
                <td>
                    <textarea id="telephone_add" name="user.telephone" class="easyui-textbox" style="width:172px;"></textarea>
                </td>
            </tr>


        </table>
        <!-- 下面是保存和取消操作（取消操作直接写在这里） -->
        <div style="text-align: center;margin-top: 20px;">
            <a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="addUser()">保存</a>
            <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel',onClick:function(){$('#addUser_dialog').dialog('close');}">取消</a>
        </div>
    </form>
</div>

<!-- 修改数据字典窗口,这里直接使用样式设置display=none(不初始化为easyui的dialog，当用户点击的时候才生成dialog),减少负荷-->
<div id="updateUser_dialog" style="display: none;">
    <form id="updateUser_form" method="post">
        <table style="text-align: right;padding: 5px 5px;">
            <tr>
                <!-- 将文本和input标签放在不同的td中，有助于施加样式，如上面设置将文本向右对齐 -->
                <td>用户名:</td>
                <td>
                    <input id="name_update" name="user.username" class="easyui-textbox" data-options="required:true" style="width:172px;">
                    <input type="hidden" id="id_update" name="user.id">
                </td>
            </tr>
            <tr>
                <td>密码:</td>
                <td><textarea id="password_update" name="user.password"  class="easyui-textbox" data-options="required:true" style="width:172px;"></textarea></td>
            </tr>

            <tr>
                <td>电子邮箱:</td>
                <td><textarea id="email_update" name="user.email"  class="easyui-textbox" data-options="required:true" style="width:172px;"></textarea></td>
            </tr>

            <tr>
                <td>手机号码:</td>
                <td><textarea id="telephone_update" name="user.telephone"  class="easyui-textbox"  style="width:172px;"></textarea></td>
            </tr>

        </table>
        <!-- 下面是保存和取消操作（取消操作直接写在这里） -->
        <div style="text-align: center;margin-top: 20px;">
            <a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="updateUser()">保存</a>
            <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel',onClick:function(){$('#updateUser_dialog').dialog('close');}">取消</a>
        </div>
    </form>
</div>


<script type="text/javascript">

    $("#userGrid").datagrid({
        title:'用户详情',
        pagination:true,
        singleSelect:true,
        rownumbers:true,
        fit:true,//此时当点击最外围的layout时整个表格可以自动适应大小
        toolbar:'#search',
        url:'<%=path%>/json/userAction!list',
        columns: [[
            {field: 'username', title: '用户名'},
            {field: 'password', title: '密码'},
            {field: 'telephone', title: '电话'},
            {field: 'email', title: '邮箱'}
        ]],
        queryParams: {//和查询时发送的请求保持一致
            'user.username': '',
        }

    });

    //查询框中的用户名查询
    $("#username").textbox({
        icons: [{
            iconCls:'icon-clear',
            handler: function(e){
                $(e.data.target).textbox('clear');
            }
        }]
    });



    //查询数据字典
    function searchUser(){
        $("#userGrid").datagrid('load',{
            'user.username':$("#username").textbox('getValue'),
        });
    }

    //真正执行保存操作
    function addUser(){
        $("#addUser_form").form('submit',{
            url:'<%=path%>/json/userAction!save',
            success:function(data){
                var data = eval('(' + data + ')');
                //如果新增成功，做三件事：1.刷新链表，2.提示新增操作成功,3.关闭新增窗口
                if(data.result == 'success'){
                    $.messager.alert('新增用户','新增成功。');
                    $("#User_datagrid").datagrid('reload');
                }else{
                    $.messager.alert('新增用户','新增失败。');
                }
                $("#addUser_dialog").dialog('close');
            }
        });
    }

    //新增数据字典(打开新增窗口)
    function add_dialog(){
        $("#addUser_dialog").css("display","block");
        //设置各字段对应的easyui插件

        $("#addUser_dialog").dialog({
            title:'新增用户项',
            width:400,
            height:300,
            modal:true
        });
    }

    //真正执行更新操作
    function updateUser(){
        $("#updateUser_form").form('submit',{
            url:'<%=path%>/json/userAction!update',
            success:function(data){
                var data = eval('(' + data + ')');
                //如果更新成功，做三件事：1.刷新链表，2.提示新增操作成功,3.关闭新增窗口
                if (data.result == 'success') {
                    $.messager.alert('修改用户','修改成功。');
                    $("#userGrid").datagrid('reload');
                } else {
                    $.messager.alert('修改用户','修改失败。');
                }
                $("#updateUser_dialog").dialog('close');
            }
        });
    }

    //打开修改数据字典
    function update_dialog(){
        var row = $("#userGrid").datagrid('getSelected');
        if (row == null) {
            $.messager.alert("修改数据字典项",'请先选中需要修改的项。','info');
            return false;
        }

        //给id赋值便于传递到后台
        $("#id_update").val(row.id);

        $("#updateUser_dialog").css("display","block");

        $("#updateUser_dialog").dialog({
            title:'修改用户信息',
            width:400,
            height:300,
            modal:true
        });
        //给各字段赋值
        $("#name_update").textbox('setValue',row.username);
        $("#password_update").textbox('setValue', row.password);
        $("#email_update").textbox('setValue', row.email);
        $("#telephone_update").textbox('setValue', row.telephone);
    }

    //删除数据字典
    function del_dialog(){
        var row = $("#userGrid").datagrid('getSelected');
        if (row == null) {
            $.messager.alert("删除用户",'请先选中需要删除的项。','info');
            return false;
        }
        $.messager.confirm('删除用户',"确定删除此条记录吗?",function(flag){
            if(flag){
                var id = row.id;
                $.ajax({
                    url:'<%=path%>/json/userAction!delete',
                    type:'post',
                    dataType:'json',
                    data:{
                        'user.id':row.id
                    },
                    success:function(data){
                        if(data.result == 'success'){
                            $.messager.alert('删除用户','删除成功。');
                            $("#userGrid").datagrid('reload');
                        }else{
                            $.messager.alert('删除用户','删除失败。');
                        }
                    }
                });
            }
        });
    }




</script>

</body>




</html>