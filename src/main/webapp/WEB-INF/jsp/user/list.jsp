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
    用户名: <input id="username" style="width:100px;">
    实验室: <input id="user_labRoom" style="width:100px;">
    <a id="user_search_btn">搜索</a><br/>
    <a id="user_add_btn">新增</a>
    <a id="user_update_btn">修改</a>
    <a id="user_remove_btn">删除</a>
</div>

<div id="addUser_dialog" style="display: none;">
    <form id="addUser_form" method="post">
        <table cellspacing="15px" style="padding: 5px 5px;">
            <tr>
                <td>用户名:</td>
                <td><input name="user.username" class="easyui-textbox" data-options="required:true" style="width:172px;"></td>
            </tr>
            <tr>
                <td>密码:</td>
                <td>
                    <input  name="user.password" class="easyui-textbox" style="width:172px;">
                </td>
            </tr>

            <tr>
                <td>性别:</td>
                <td>
                    <input type="radio" name="user.sex" value="男">男
                    <input type="radio" name="user.sex" value="女">女
                </td>
            </tr>

            <tr>
                <td>出生年月:</td>
                <td><input class="easyui-datebox" name="user.birthday" style="width:172px;"></td>
            </tr>

            <tr>
                <td>所学专业:</td>
                <td>
                    <input id="user_speciality_add" name="user.specialty"  class="easyui-textbox" style="width:172px;">
                </td>
            </tr>
            <tr>
                <td>教育背景:</td>
                <td>
                    <input id="user_education_add" name="user.education" class="easyui-textbox" style="width:172px;">
                </td>
            </tr>

            <tr>
                <td>所属实验室:</td>
                <td><input id="user_labRoom_add" name="user.labRoom.id" style="width:172px;"></td>
            </tr>

            <tr>
                <td>入学日期:</td>
                <td><input class="easyui-datebox" name="user.enrolDate" style="width:172px;"></td>
            </tr>

            <tr>
                <td>电子邮箱:</td>
                <td>
                    <input name="user.email"  class="easyui-textbox" style="width:172px;">
                </td>
            </tr>

            <tr>
                <td>手机号码:</td>
                <td><input name="user.telephone"  class="easyui-textbox"  style="width:172px;"></td>
            </tr>

            <tr>
                <td>备注:</td>
                <td>
                    <textarea name="user.remark" placeholder="不超过120个字符" rows="5" maxlength="120" class="textbox" style="resize:none;width:160px;white-space:pre-wrap;padding: 5px"></textarea>
                </td>
            </tr>
        </table>

    </form>
</div>

<div id="updateUser_dialog" style="display: none;">
    <form id="updateUser_form" method="post">
        <table cellspacing="15px" style="padding: 5px 5px;">
            <tr>
                <td>用户名:</td>
                <td>
                    <input id="user_name_update" name="user.username" class="easyui-textbox" style="width:172px;">
                    <input type="hidden" id="user_id_update" name="user.id">
                </td>
            </tr>
            <tr>
                <td>密码:</td>
                <td><input id="user_password_update" name="user.password"  class="easyui-textbox" style="width:172px;"></td>
            </tr>

            <tr>
                <td>性别:</td>
                <td>
                    <input id="user_sex_man" type="radio" name="user.sex" value="男">男
                    <input id="user_sex_women" type="radio" name="user.sex" value="女">女
                </td>
            </tr>

            <tr>
                <td>出生年月:</td>
                <td><input id="user_birthday_update" class="easyui-datebox" name="user.birthday" style="width:172px;"></td>
            </tr>

            <tr>
                <td>所学专业:</td>
                <td>
                    <input id="user_speciality_update" name="user.specialty"  class="easyui-textbox" style="width:172px;">
                </td>
            </tr>
            <tr>
                <td>教育背景:</td>
                <td>
                    <input id="user_education_update" name="user.education" class="easyui-textbox" style="width:172px;">
                </td>
            </tr>

            <tr>
                <td>入学日期:</td>
                <td><input id="user_enrolDate_update" name="user.enrolDate" class="easyui-datebox" style="width:172px;"></td>
            </tr>

            <tr>
                <td>所属实验室:</td>
                <td><input id="user_labRoom_update" name="user.labRoom.id" style="width:172px;"></td>
            </tr>

            <tr>
                <td>电子邮箱:</td>
                <td><textarea id="user_email_update" name="user.email"  class="easyui-textbox" style="width:172px;"></textarea></td>
            </tr>

            <tr>
                <td>手机号码:</td>
                <td><input id="telephone_update" name="user.telephone"  class="easyui-textbox"  style="width:172px;"></td>
            </tr>

            <tr>
                <td>备注:</td>
                <td>
                    <textarea id="user_remark_update" name="user.remark" placeholder="不超过120个字符" rows="5" maxlength="120" class="textbox" style="resize:none;width:160px;white-space:pre-wrap;padding: 5px"></textarea>
                </td>
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

        //根据实验室查询
        $("#user_labRoom").textbox({
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
                    'user.labRoom.name':$("#user_labRoom").textbox('getValue'),
                });
            }
        })

        //新增按钮
        $("#user_add_btn").linkbutton({
            iconCls : 'icon-add',
            onClick : function(){
                $("#addUser_dialog").css("display","block");

                $("#addUser_form").form('clear');

                //所属实验室
                $("#user_labRoom_add").combobox({
                    url:'<%=path%>/json/labRoomAction!getAll',
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

                //所学专业
                $("#user_speciality_add").combobox({
                    url:'<%=path%>/json/dictionaryAction!getTopX',
                    queryParams : {
                        topX : '所学专业',
                    },
                    valueField:'code',
                    textField:'name',
                    panelHeight : true,
                    editable:false,
                    icons:[{
                        iconCls:'icon-clear',
                        handler:function(e){
                            $(e.data.target).combobox('clear');
                        }
                    }],
                    onLoadSuccess : function () {//默认选中第一项
                        var data = $("#user_speciality_add").combobox('getData');
                        if(data.length > 0){
                            $("#user_speciality_add").combobox('setValue', data[0].code);
                        }
                    }
                });

                //教育背景
                $("#user_education_add").combobox({
                    url:'<%=path%>/json/dictionaryAction!getTopX',
                    queryParams : {
                        topX : '教育背景',
                    },
                    valueField:'code',
                    textField:'name',
                    panelHeight : true,
                    editable:false,
                    icons:[{
                        iconCls:'icon-clear',
                        handler:function(e){
                            $(e.data.target).combobox('clear');
                        }
                    }],
                    onLoadSuccess : function () {//默认选中第一项
                        var data = $("#user_education_add").combobox('getData');
                        if(data.length > 0){
                            $("#user_education_add").combobox('setValue', data[0].code);
                        }
                    }
                });

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
                                    try{
                                        var res = eval('(' + data + ')');
                                        if(res.result == 'success') {
                                            $.messager.show({
                                                title: '新增用户',
                                                msg: '新增成功!',
                                                timeout: 2000,
                                            });
                                            $("#userGrid").datagrid('reload');
                                            $("#addUser_dialog").dialog('close');
                                        }
                                    }catch(err){
                                        $.messager.alert('新增用户',data, 'error');
                                    }
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

                //所属实验室
                $("#user_labRoom_update").combobox({
                    url:'<%=path%>/json/labRoomAction!getAll',
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

                //所学专业
                $("#user_speciality_update").combobox({
                    url:'<%=path%>/json/dictionaryAction!getTopX',
                    queryParams : {
                        topX : '所学专业',
                    },
                    valueField:'code',
                    textField:'name',
                    panelHeight : true,
                    editable:false,
                    icons:[{
                        iconCls:'icon-clear',
                        handler:function(e){
                            $(e.data.target).combobox('clear');
                        }
                    }]
                });

                //教育背景
                $("#user_education_update").combobox({
                    url:'<%=path%>/json/dictionaryAction!getTopX',
                    queryParams : {
                        topX : '教育背景',
                    },
                    valueField:'code',
                    textField:'name',
                    panelHeight : true,
                    editable:false,
                    icons:[{
                        iconCls:'icon-clear',
                        handler:function(e){
                            $(e.data.target).combobox('clear');
                        }
                    }]
                });

                $("#updateUser_dialog").dialog({
                    title:'修改用户信息',
                    modal:true, buttons: [{
                        text: '保存',
                        iconCls: 'icon-ok',
                        handler: function () {
                            $("#updateUser_form").form('submit',{
                                url:'<%=path%>/json/userAction!update',
                                success:function(data){
                                    try{
                                        var res = eval('(' + data + ')');
                                        //如果更新成功，做三件事：1.刷新链表，2.提示新增操作成功,3.关闭新增窗口
                                        if (res.result == 'success') {
                                            $.messager.show({
                                                title : '修改用户',
                                                msg : '修改成功!',
                                                timeout : 2000,
                                            });
                                            $("#userGrid").datagrid('reload');
                                            $("#updateUser_dialog").dialog('close');
                                        }
                                    }catch (err){
                                        $.messager.alert('修改用户',data, 'error');
                                    }


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
                $("#user_name_update").textbox('setValue',row.username);
                $("#user_password_update").textbox('setValue', row.password);
                if(row.sex == '男'){
                    $("#user_sex_man").attr("checked",true);
                }else if(row.sex == '女'){
                    $("#user_sex_woman").attr("checked",true);
                }
                //所学专业
                if(row.specialty){//只有有值时才赋值，否则使用默认值
                    $("#user_speciality_update").combobox('setValue', row.specialty);
                }else {
                    var data = $("#user_speciality_update").combobox('getData');
                    if(data.length > 0){
                        $("#user_speciality_update").combobox('setValue', data[0].code);
                    }
                }
                //专业背景
                if(row.education){//只有有值时才赋值，否则使用默认值
                    $("#user_education_update").combobox('setValue', row.education);
                }else {
                    var data = $("#user_education_update").combobox('getData');
                    if(data.length > 0){
                        $("#user_education_update").combobox('setValue', data[0].code);
                    }
                }
                //所属实验室
                $("#user_labRoom_update").combobox('setValue', row.labRoom.id);
                $("#user_enrolDate_update").datebox('setValue', row.enrolDate);
                $("#user_birthday_update").datebox('setValue', row.birthday);
                $("#user_email_update").textbox('setValue', row.email);
                $("#telephone_update").textbox('setValue', row.telephone);
                $("#user_remark_update").textbox('setValue', row.remark);

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
                {field: 'sex', title: '性别'},
                {
                    field: 'birthday', title: '出生年月',
                    formatter : function (value, row, index) {
                        return getDate(value);
                    }
                },
                {
                    field: 'specialty', title: '所学专业',
                    formatter: function (value, row, index) {
                        switch (value){//todo:这里好像有bug，万一在数据字典中做了更改？
                            case 0 :
                                return "数学"
                            case 1 :
                                return "英语";
                            case 2 :
                                return "物理";
                        }
                    }
                },
                {
                    field: 'education', title: '教育背景',
                    formatter: function (value, row, index) {
                        switch (value){//todo:这里好像有bug，万一在数据字典中做了更改？
                            case 0 :
                                return "本科生"
                            case 1 :
                                return "研究生";
                            case 2 :
                                return "博士生";
                        }
                    }
                },
                {
                    field: 'enrolDate', title: '入学日期',
                    formatter : function (value, row, index) {
                        return getDate(value);
                    }
                },
                {
                    field: 'labRoom', title: '所属实验室',
                    formatter : function (value, row, index) {
                        if (row.labRoom){
                            return row.labRoom.name;
                        }
                    }
                },
                {field: 'telephone', title: '电话'},
                {field: 'email', title: '邮箱'},
                {field: 'remark', title: '备注'},
            ]],
            queryParams: {//和查询时发送的请求保持一致
                'user.username': '',
                'user.labRoom.name': '',
            }

        });
    });


</script>

</body>
</html>