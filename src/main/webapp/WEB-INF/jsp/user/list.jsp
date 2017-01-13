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
    <a id="user_search_btn">搜索</a><br/>
    <a id="user_add_btn">新增</a>
    <a id="user_update_btn">修改</a>
    <a id="user_remove_btn">删除</a>
</div>

<div id="addUser_dialog" style="display: none;">
    <form id="addUser_form" method="post">
        <table cellspacing="15px" style="text-align: right;padding: 5px 5px;">
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

    </form>
</div>

<div id="updateUser_dialog" style="display: none;">
    <form id="updateUser_form" method="post">
        <table cellspacing="15px" style="text-align: right;padding: 5px 5px;">
            <tr>
                <!-- 将文本和input标签放在不同的td中，有助于施加样式，如上面设置将文本向右对齐 -->
                <td>用户名:</td>
                <td>
                    <input id="name_update" name="user.username" class="easyui-textbox" data-options="required:true" style="width:172px;">
                    <input type="hidden" id="user_id_update" name="user.id">
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

    </form>
</div>


<script type="text/javascript">

    $(function () {
        //根据用户名查询
        $("#username").textbox({
            icons: [{
                iconCls:'icon-clear',
                handler: function(e){
                    $(e.data.target).textbox('clear');
                }
            }]
        });

        //查询按钮
        $("#user_search_btn").linkbutton({
            iconCls : 'icon-search',
            onClick : function(){
                $("#userGrid").datagrid('load',{
                    'user.username':$("#username").textbox('getValue'),
                });
            }
        })

        //新增按钮
        $("#user_add_btn").linkbutton({
            iconCls : 'icon-add',
            onClick : function(){
                $("#addUser_dialog").css("display","block");

                $("#addUser_form").form('clear');

                $("#addUser_dialog").dialog({
                    title:'新增用户项',
                    modal:true,
                    buttons: [{
                        text: '保存',
                        iconCls: 'icon-ok',
                        handler: function () {
                            $("#addUser_form").form('submit',{
                                url:'<%=path%>/json/userAction!save',
                                success:function(data){
                                    var data = eval('(' + data + ')');
                                    //如果新增成功，做三件事：1.刷新链表，2.提示新增操作成功,3.关闭新增窗口
                                    if(data.result == 'success'){
                                        $.messager.show({
                                            title : '新增用户',
                                            msg : '新增成功!',
                                            timeout : 2000
                                        });
                                        $("#User_datagrid").datagrid('reload');
                                    }else{
                                        $.messager.alert('新增用户','新增失败。');
                                    }
                                    $("#addUser_dialog").dialog('close');
                                }
                            });

                        }
                    }, {
                        text: '取消',
                        iconCls: 'icon-cancel',
                        handler: function () {
                            $('#addUser_dialog').dialog('close');
                        }
                    }],
                });
            }
        })

        //更新按钮
        $("#user_update_btn").linkbutton({
            iconCls : 'icon-edit',
            onClick : function(){
                var row = $("#userGrid").datagrid('getSelected');
                if (row == null) {
                    $.messager.alert("修改数据字典项",'请先选中需要修改的项。','info');
                    return false;
                }

                //给id赋值便于传递到后台
                $("#user_id_update").val(row.id);

                $("#updateUser_dialog").css("display","block");

                $("#updateUser_dialog").dialog({
                    title:'修改用户信息',
                    modal:true, buttons: [{
                        text: '保存',
                        iconCls: 'icon-ok',
                        handler: function () {
                            $("#updateUser_form").form('submit',{
                                url:'<%=path%>/json/userAction!update',
                                success:function(data){
                                    var data = eval('(' + data + ')');
                                    //如果更新成功，做三件事：1.刷新链表，2.提示新增操作成功,3.关闭新增窗口
                                    if (data.result == 'success') {
                                        $.messager.show({
                                            title : '修改用户',
                                            msg : '修改成功!',
                                            timeout : 2000
                                        });
                                        $("#userGrid").datagrid('reload');
                                    } else {
                                        $.messager.alert('修改用户','修改失败。');
                                    }
                                    $("#updateUser_dialog").dialog('close');
                                }
                            })
                        }
                    }, {
                        text: '取消',
                        iconCls: 'icon-cancel',
                        handler: function () {
                            $('#updateUser_dialog').dialog('close');
                        }
                    }],
                });
                //给各字段赋值
                $("#name_update").textbox('setValue',row.username);
                $("#password_update").textbox('setValue', row.password);
                $("#email_update").textbox('setValue', row.email);
                $("#telephone_update").textbox('setValue', row.telephone);

            }
        })

        //删除按钮
        $("#user_remove_btn").linkbutton({
            iconCls : 'icon-remove',
            onClick : function(){
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
                                    $.messager.show({
                                        title : '删除用户',
                                        msg : '删除成功!',
                                        timeout : 2000
                                    });
                                    $("#userGrid").datagrid('reload');
                                }else{
                                    $.messager.alert('删除用户','删除失败。');
                                }
                            }
                        });
                    }
                });

            }
        })

        //主体表格
        $("#userGrid").datagrid({
            title:'用户详情',
            pagination:true,
            singleSelect:true,
            rownumbers:true,
            fit:true,
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
    });


</script>

</body>
</html>