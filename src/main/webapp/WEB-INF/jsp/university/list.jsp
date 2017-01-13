<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="/WEB-INF/reuse/path.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>

<table id="universityGrid"></table>

<!-- 查询工具条 -->
<div id="university_search">
    学校名称: <input id="university_search_name" name="university.name" style="width:100px;">
    <a id="university_search_btn">搜索</a><br/>
    <a id="university_add_btn">新增</a>
    <a id="university_update_btn">修改</a>
    <a id="university_remove_btn">删除</a>
</div>

<!-- 新增窗口,这里直接使用样式设置display=none(不初始化为easyui的dialog，当学校点击的时候才生成dialog),减少负荷-->
<div id="addUniversity_dialog" style="display: none;">
    <form id="addUniversity_form" method="post">
        <table cellspacing="10px" style="text-align: right;padding: 5px 5px;">
            <tr>
                <td>学校编号:</td>
                <td><input name="university.code" class="easyui-textbox" data-options="required:true" style="width:172px;"></td>
            </tr>
            <tr>
                <td>学校名称:</td>
                <td><input name="university.name" class="easyui-textbox" data-options="required:true" style="width:172px;"></td>
            </tr>
            <tr>
                <td>学校简称:</td>
                <td><input name="university.shortName" class="easyui-textbox" style="width:172px;"></td>
            </tr>
            <tr>
                <td>学校地址:</td>
                <td>
                    <input name="university.address" data-options="required:true" class="easyui-textbox" style="width:172px;">
                </td>
            </tr>
            <tr>
                <td>学校建立日期:</td>
                <td><input class="easyui-datebox" name="university.buildDate" style="width:172px;"></td>
            </tr>
            <tr>
                <td>学校简介:</td>
                <td>
                    <textarea name="university.description" rows="10" class="textbox" style="resize:none;width:160px;white-space:pre-wrap;padding: 5px"></textarea>
                </td>
            </tr>
        </table>
    </form>
</div>

<!-- 修改窗口,这里直接使用样式设置display=none(不初始化为easyui的dialog，当学校点击的时候才生成dialog),减少负荷-->
<div id="updateUniversity_dialog" style="display: none;">
    <form id="updateUniversity_form" method="post">
        <table cellspacing="10px" style="text-align: right;padding: 5px 5px;">
            <tr>
                <td>学校编号:</td>
                <td><input id="university_code_update" name="university.code" class="easyui-textbox" data-options="required:true" style="width:172px;"></td>
            </tr>
            <tr>
                <td>学校名称:</td>
                <td>
                    <input id="university_name_update" name="university.name" class="easyui-textbox" data-options="required:true" style="width:172px;">
                    <input type="hidden" id="university_id_update" name="university.id">
                </td>
            </tr>
            <tr>
                <td>学校简称:</td>
                <td><input id="university_shortName_update" name="university.shortName" class="easyui-textbox" style="width:172px;"></td>
            </tr>
            <tr>
                <td>学校地址:</td>
                <td><textarea id="university_address_update" name="university.address"  class="easyui-textbox" data-options="required:true" style="width:172px;"></textarea></td>
            </tr>
            <tr>
                <td>学校建立日期:</td>
                <td><input id="university_buildDate_update" class="easyui-datebox" name="university.buildDate" style="width:172px;"></td>
            </tr>
            <tr>
                <td>学校简介:</td>
                <td>
                    <textarea id="university_description_update" name="university.description" rows="10" maxlength="120" class="textbox" style="resize:none;width:160px;white-space:pre-wrap;padding: 5px"></textarea>
                </td>
            </tr>
        </table>
    </form>
</div>


<script type="text/javascript">

    $(function () {
        //根据学校名称查询
        $("#university_search_name").textbox({
            icons: [{
                iconCls:'icon-clear',
                handler: function(e){
                    $(e.data.target).textbox('clear');
                }
            }]
        });

        //搜索按钮
        $("#university_search_btn").linkbutton({
            iconCls : 'icon-search',
            onClick : function () {
                $("#universityGrid").datagrid('load',{
                    'university.name':$("#university_search_name").textbox('getValue'),
                });
            }
        });

        //新增按钮
        $("#university_add_btn").linkbutton({
            iconCls : 'icon-add',
            onClick : function () {
                $("#addUniversity_dialog").css("display","block");

                $("#addUniversity_form").form('clear');

                $("#university_director_add").combobox({
                    url:'<%=path%>/json/universityAction!getUser',
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

                $("#addUniversity_dialog").dialog({
                    title:'新增学校项',
                    modal:true,
                    buttons: [{
                        text: '保存',
                        iconCls: 'icon-ok',
                        handler: function () {
                            $("#addUniversity_form").form('submit',{
                                url:'<%=path%>/json/universityAction!save',
                                success:function(data){
                                    var data = eval('(' + data + ')');
                                    //如果新增成功，做三件事：1.刷新链表，2.提示新增操作成功,3.关闭新增窗口
                                    if(data.result == 'success'){
                                        $.messager.show({
                                            title : '新增学校',
                                            msg : '新增成功!',
                                            timeout : 2000
                                        });
                                        $("#universityGrid").datagrid('reload');
                                    }else{
                                        $.messager.alert('新增学校','新增失败。');
                                    }
                                    $("#addUniversity_dialog").dialog('close');
                                }
                            });
                        }
                    }, {
                        text: '取消',
                        iconCls: 'icon-cancel',
                        handler: function () {
                            $('#addUniversity_dialog').dialog('close');
                        }
                    }],
                });
            }
        });

        //更新按钮
        $("#university_update_btn").linkbutton({
            iconCls : 'icon-edit',
            onClick : function () {
                var row = $("#universityGrid").datagrid('getSelected');
                if (row == null) {
                    $.messager.alert("修改学校信息",'请先选中需要修改的学校。','info');
                    return false;
                }

                //给id赋值便于传递到后台
                $("#university_id_update").val(row.id);

                $("#updateUniversity_dialog").css("display","block");

                $("#updateUniversity_dialog").dialog({
                    title:'修改学校信息',
                    modal:true,
                    buttons: [{
                        text: '保存',
                        iconCls: 'icon-ok',
                        handler: function () {
                            $("#updateUniversity_form").form('submit',{
                                url:'<%=path%>/json/universityAction!update',
                                success:function(data){
                                    var data = eval('(' + data + ')');
                                    //如果更新成功，做三件事：1.刷新链表，2.提示新增操作成功,3.关闭新增窗口
                                    if (data.result == 'success') {
                                        $.messager.show({
                                            title : '修改学校',
                                            msg : '修改成功!',
                                            timeout : 2000,//停留2秒，默认为4秒
                                        });
                                        $("#universityGrid").datagrid('reload');
                                    } else {
                                        $.messager.alert('修改学校','修改失败。');
                                    }
                                    $("#updateUniversity_dialog").dialog('close');
                                }
                            });
                        }
                    }, {
                        text: '取消',
                        iconCls: 'icon-cancel',
                        handler: function () {
                            $('#updateUniversity_dialog').dialog('close');
                        }
                    }],
                });
                //给各字段赋值
                $("#university_code_update").textbox('setValue',row.code);
                $("#university_name_update").textbox('setValue',row.name);
                $("#university_shortName_update").textbox('setValue',row.shortName);
                $("#university_address_update").textbox('setValue', row.address);
                $("#university_buildDate_update").datebox('setValue',row.buildDate);
                $("#university_description_update").textbox('setValue',row.description);
            }
        });

        //删除按钮
        $("#university_remove_btn").linkbutton({
            iconCls : 'icon-remove',
            onClick : function () {
                var row = $("#universityGrid").datagrid('getSelected');
                if (row == null) {
                    $.messager.alert("删除学校",'请先选中需要删除的学校。','info');
                    return false;
                }
                $.messager.confirm('删除学校',"确定删除此条记录吗?",function(flag){
                    if(flag){
                        var id = row.id;
                        $.ajax({
                            url:'<%=path%>/json/universityAction!delete',
                            type:'post',
                            dataType:'json',
                            data:{
                                'university.id':row.id
                            },
                            success:function(data){
                                if(data.result == 'success'){
                                    $.messager.show({
                                        title : '删除学校',
                                        msg : '删除成功!',
                                        timeout : 2000,//停留2秒，默认为4秒
                                    });
                                    $("#universityGrid").datagrid('reload');
                                }else{
                                    $.messager.alert('删除学校','删除失败。');
                                }
                            }
                        });
                    }
                });
            }
        });

        //主体表格
        $("#universityGrid").datagrid({
            title:'学校管理',
            pagination:true,
            singleSelect:true,
            rownumbers:true,
            fit:true,
            toolbar:'#university_search',
            url:'<%=path%>/json/universityAction!list',
            columns: [[
                {field: 'code', title: '学校编号'},
                {field: 'name', title: '学校名称'},
                {field: 'shortName', title: '学校简称'},
                {
                    field: 'buildDate', title: '学校室建立时间',
                    formatter : function (value, row, index) {
                        if(value){
                            var date = new Date(value);
                            return date.getFullYear() + "-" + date.getMonth() + "-" + date.getDate();
                        }
                    }
                },
                {field: 'description', title: '学校简介'},
            ]],
            queryParams: {//和查询时发送的请求保持一致
                'university.name': '',
            }
        });
    });

</script>

</body>




</html>