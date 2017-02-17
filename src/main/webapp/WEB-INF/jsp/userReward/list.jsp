<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="/WEB-INF/reuse/path.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>

<table id="userRewardGrid"></table>

<!-- 查询工具条 -->
<div id="userReward_search">
    获奖人: <input id="userReward_user_name" style="width:100px;">
    <a id="userReward_search_btn">搜索</a><br/>
    <a id="userReward_add_btn">新增</a>
    <a id="userReward_update_btn">修改</a>
    <a id="userReward_remove_btn">删除</a>
</div>

<div id="adduserReward_dialog" style="display: none;">
    <form id="adduserReward_form" method="post">
        <table cellspacing="10px" style="padding: 5px 5px;">
            <tr>
                <td>获奖名称:</td>
                <td><input id="userReward_name_add" name="userReward.name" class="easyui-textbox" data-options="required:true" style="width:172px;"></td>
            </tr>

            <tr>
                <td>获奖人:</td>
                <td>
                    <input id="userReward_user_add" name="userReward.user.id" style="width:172px;">
                </td>
            </tr>

            <tr>
                <td>获奖日期:</td><!--这里使用datebox的默认值即可-->
                <td><input id="userReward_rewardDate_add" class="easyui-datebox" name="userReward.rewardDate" style="width:172px;"></td>
            </tr>

            <tr>
                <td>获奖级别:</td>
                <td><input id="userReward_level_add" name="userReward.level" style="width:172px;"></td>
            </tr>

            <tr>
                <td>是否专利:</td>
                <td>
                    <input type="radio" name="userReward.patented" value="true">是
                    <input type="radio" name="userReward.patented" value="false">否
                </td>
            </tr>

            <tr>
                <td>审核通过:</td>
                <td>
                    <input type="radio" name="userReward.verified" value="true">是
                    <input type="radio" name="userReward.verified" value="false">否
                </td>
            </tr>

            <tr>
                <td>备注:</td>
                <td>
                    <textarea id="userReward_remark_add" name="userReward.remark" placeholder="不超过120个字符" rows="5" maxlength="120" class="textbox" style="resize:none;width:160px;white-space:pre-wrap;padding: 5px"></textarea>
                </td>
            </tr>

        </table>
    </form>
</div>

<div id="updateuserReward_dialog" style="display: none;">
    <form id="updateuserReward_form" method="post">
        <table cellspacing="10px" style="padding: 5px 5px;">
            <tr>
                <td>获奖名称:</td>
                <td>
                    <input id="userReward_name_update" name="userReward.name" class="easyui-textbox" data-options="required:true" style="width:172px;">
                    <input type="hidden" id="userReward_id_update" name="userReward.id">
                </td>
            </tr>
            <tr>
                <td>获奖人:</td>
                <td>
                    <input id="userReward_user_update" name="userReward.user.id" style="width:172px;">
                </td>
            </tr>

            <tr>
                <td>获奖日期:</td>
                <td><input id="userReward_rewardDate_update" class="easyui-datebox" name="userReward.rewardDate" style="width:172px;"></td>
            </tr>


            <tr>
                <td>获奖级别:</td>
                <td><input id="userReward_level_update" name="userReward.level" style="width:172px;"></td>
            </tr>

            <tr>
                <td>是否专利:</td>
                <td>
                    <input type="radio" id="userReward_patented_update_Yes" name="userReward.patented" value="true">是
                    <input type="radio" id="userReward_patented_update_No" name="userReward.patented" value="false">否
                </td>
            </tr>

            <tr>
                <td>审核通过:</td>
                <td>
                    <input type="radio" id="userReward_verified_update_Yes" name="userReward.verified" value="true">是
                    <input type="radio" id="userReward_verified_update_No" name="userReward.verified" value="false">否
                </td>
            </tr>

            <tr>
                <td>备注:</td>
                <td>
                    <textarea id="userReward_remark_update" name="userReward.remark" placeholder="不超过120个字符" rows="5" maxlength="120" class="textbox" style="resize:none;width:160px;white-space:pre-wrap;padding: 5px"></textarea>
                </td>
            </tr>
        </table>

    </form>
</div>


<script type="text/javascript">

    $(function () {

        //根据获奖人查询
        $("#userReward_user_name").textbox({
            icons: [{
                iconCls:'icon-clear',
                handler: function(e){
                    $(e.data.target).textbox('clear');
                }
            }]
        });


        //查询按钮
        $("#userReward_search_btn").linkbutton({
            iconCls : 'icon-search',
            onClick : function(){
                $("#userRewardGrid").datagrid('load',{
                    'userReward.user.username':$("#userReward_user_name").textbox('getValue'),
                });
            }
        })

        //新增按钮
        $("#userReward_add_btn").linkbutton({
            iconCls : 'icon-add',
            onClick : function(){
                $("#adduserReward_dialog").css("display","block");

                $("#adduserReward_form").form('clear');

                //获奖人
                $("#userReward_user_add").combobox({
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

                //获奖级别
                $("#userReward_level_add").combobox({
                    url:'<%=path%>/json/dictionaryAction!getTopX',
                    queryParams : {
                        topX : '获奖级别',
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
                        var data = $("#userReward_level_add").combobox('getData');
                        if(data.length > 0){
                            $("#userReward_level_add").combobox('setValue', data[0].code);
                        }
                    }
                });

                $("#adduserReward_dialog").dialog({
                    title:'新增实验室人员获奖',
                    modal:true,
                    buttons: [{
                        text: '保存',
                        iconCls: 'icon-ok',
                        handler: function () {
                            $("#adduserReward_form").form('submit',{
                                url:'<%=path%>/json/userRewardAction!save',
                                success:function(data){
                                    try{
                                        var res = eval('(' + data + ')');
                                        if(res.result == 'success') {
                                            $.messager.show({
                                                title: '新增实验室人员获奖',
                                                msg: '新增成功!',
                                                timeout: 2000,
                                            });
                                            $("#userRewardGrid").datagrid('reload');
                                            $("#adduserReward_dialog").dialog('close');
                                        }
                                    }catch(err){
                                        $.messager.alert('新增实验室人员获奖',data, 'error');
                                    }
                                }
                            })
                        }
                    }, {
                        text: '取消',
                        iconCls: 'icon-cancel',
                        handler: function () {
                            $('#adduserReward_dialog').dialog('close');
                        }
                    }],
                });

            }
        })

        //更新按钮
        $("#userReward_update_btn").linkbutton({
            iconCls : 'icon-edit',
            onClick : function(){
                $("#userReward_user_update").combobox({
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

                //获奖级别
                $("#userReward_level_update").combobox({
                    url:'<%=path%>/json/dictionaryAction!getTopX',
                    queryParams : {
                        topX : '获奖级别',
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

                var row = $("#userRewardGrid").datagrid('getSelected');
                if (row == null) {
                    $.messager.alert("修改实验室人员获奖",'请先选中需要修改的项。','info');
                    return false;
                }

                //给id赋值便于传递到后台
                $("#userReward_id_update").val(row.id);

                $("#updateuserReward_dialog").css("display","block");

                $("#updateuserReward_dialog").dialog({
                    title:'修改实验室人员获奖信息',
                    modal:true,
                    buttons: [{
                        text: '保存',
                        iconCls: 'icon-ok',
                        handler: function () {
                            $("#updateuserReward_form").form('submit',{
                                url:'<%=path%>/json/userRewardAction!update',
                                success:function(data){
                                    $("#updateuserReward_dialog").dialog('close');

                                    try{
                                        var res = eval('(' + data + ')');
                                        //如果更新成功，做三件事：1.刷新链表，2.提示新增操作成功,3.关闭新增窗口
                                        if (res.result == 'success') {
                                            $.messager.show({
                                                title : '修改实验室人员获奖获奖',
                                                msg : '修改成功!',
                                                timeout : 2000,
                                            });
                                            $("#userRewardGrid").datagrid('reload');
                                            $("#updateuserReward_dialog").dialog('close');
                                        }
                                    }catch (err){
                                        $.messager.alert('修改实验室人员获奖获奖',data, 'error');
                                    }


                                }
                            })
                        }
                    }, {
                        text: '取消',
                        iconCls: 'icon-cancel',
                        handler: function () {
                            $('#updateuserReward_dialog').dialog('close');
                        }
                    }],
                });
                //给各字段赋值
                $("#userReward_name_update").textbox('setValue',row.name);

                $("#userReward_user_update").combobox('setValue', row.user.id);

                $("#userReward_hiredInstitution_update").textbox('setValue', row.hiredInstitution);

                if(row.level){//只有有值时才赋值，否则使用默认值
                    $("#userReward_level_update").combobox('setValue', row.level);
                }else {
                    var data = $("#userReward_level_update").combobox('getData');
                    if(data.length > 0){
                        $("#userReward_level_update").combobox('setValue', data[0].code);
                    }
                }


                if(row.patented){
                    $("#userReward_patented_update_Yes").attr("checked",true);
                }else{
                    $("#userReward_patented_update_No").attr("checked",true);
                }

                if(row.verified){
                    $("#userReward_verified_update_Yes").attr("checked",true);
                }else{
                    $("#userReward_verified_update_No").attr("checked",true);
                }


                $("#userReward_rewardDate_update").datebox('setValue', row.rewardDate);
                $("#userReward_remark_update").val(row.remark);
            }
        })

        //删除按钮
        $("#userReward_remove_btn").linkbutton({
            iconCls : 'icon-remove',
            onClick : function(){
                var row = $("#userRewardGrid").datagrid('getSelected');
                if (row == null) {
                    $.messager.alert("删除科研获奖",'请先选中需要删除的项。','info');
                    return false;
                }
                $.messager.confirm('删除科研获奖',"确定删除此条记录吗?",function(flag){
                    if(flag){
                        var id = row.id;
                        $.ajax({
                            url:'<%=path%>/json/userRewardAction!delete',
                            type:'post',
                            dataType:'json',
                            data:{
                                'userReward.id':row.id
                            },
                            success:function(data){
                                if(data.result == 'success'){
                                    $.messager.show({
                                        title : '删除科研获奖',
                                        msg : '删除成功!',
                                        timeout : 2000,
                                    });
                                    $("#userRewardGrid").datagrid('reload');
                                }else{
                                    $.messager.alert('删除科研获奖','删除失败。');
                                }
                            }
                        });
                    }
                });

            }
        })

        //主体表格
        $("#userRewardGrid").datagrid({
            title:'实验室人员获奖管理',
            pagination:true,
            singleSelect:true,
            rownumbers:true,
            fit:true,
            toolbar:'#userReward_search',
            url:'<%=path%>/json/userRewardAction!list',
            columns: [[
                {field: 'name', title: '获奖名称'},
                {
                    field: 'user', title: '获奖人',
                    formatter: function (value, row, index) {
                        if (row.user){
                            return row.user.username;
                        }
                    }
                },
                {
                    field: 'rewardDate', title: '发表日期',
                    formatter : function (value, row, index) {
                        return getDate(value);
                    }
                },
                {
                    field: 'level', title: '获奖级别',
                    formatter: function (value, row, index) {
                        switch (value){
                            case 0 :
                                return "未获奖"
                            case 1 :
                                return "国际奖";
                            case 2 :
                                return "国家奖";
                            case 3 :
                                return "省市部委奖";
                            case 4 :
                                return "校级奖";
                        }
                    }
                },
                {
                    field: 'patented', title: '是否专利',
                    formatter : function (value, row, index) {
                        if (value){
                            return "是";
                        }else {
                            return "否";
                        }
                    }
                },
                {
                    field: 'verified', title: '审核通过',
                    formatter : function (value, row, index) {
                        if (value){
                            return "是";
                        }else {
                            return "否";
                        }
                    }
                },
                {field: 'remark', title: '备注'},
            ]],
            queryParams: {//和查询时发送的请求保持一致
                'userReward.user.username' : '',
            }
        });
    });


</script>

</body>

</html>