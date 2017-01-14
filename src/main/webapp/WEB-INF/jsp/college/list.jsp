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
    学院名称: <input id="college_search_name" name="labRoom.name" style="width:100px;">
    <a id="college_search_btn">搜索</a><br/>
    <a id="college_add_btn">新增</a>
    <a id="college_update_btn">修改</a>
    <a id="college_remove_btn">删除</a>
</div>

<!-- 新增数据字典窗口,这里直接使用样式设置display=none(不初始化为easyui的dialog，当学院点击的时候才生成dialog),减少负荷-->
<div id="addCollege_dialog" style="display: none;">
    <form id="addCollge_form" method="post">
        <table cellspacing="10px" style="text-align: right;padding: 5px 5px;">
            <tr>
                <td>学院编号:</td>
                <td><input name="college.code" class="easyui-textbox" data-options="required:true" style="width:172px;"></td>
            </tr>
            <tr>
                <!-- 将文本和input标签放在不同的td中，有助于施加样式，如上面设置将文本向右对齐 -->
                <td>学院名称:</td>
                <td><input  name="college.name" class="easyui-textbox" data-options="required:true" style="width:172px;"></td>
            </tr>
            <tr>
                <td>学院简称:</td>
                <td><input name="college.shortName" class="easyui-textbox" style="width:172px;"></td>
            </tr>

            <tr>
                <td>院长:</td>
                <td><input id="college_dean_add" name="college.dean.id" style="width:172px;"></td>
            </tr>

            <tr>
                <td>所属学校:</td>
                <td><input id="college_university_add" name="college.university.id" style="width:172px;"></td>
            </tr>
            <tr>
                <td>学院建立日期:</td>
                <td><input class="easyui-datebox" name="college.buildDate" style="width:172px;"></td>
            </tr>
            <tr>
                <td>学院简介:</td>
                <td>
                    <textarea name="college.description" rows="10" class="textbox" style="resize:none;width:160px;white-space:pre-wrap;padding: 5px"></textarea>
                </td>
            </tr>
        </table>
    </form>
</div>

<div id="updateCollege_dialog" style="display: none;">
    <form id="updateCollege_form" method="post">
        <table cellspacing="10px" style="text-align: right;padding: 5px 5px;">
            <tr>
                <td>学院编号:</td>
                <td><input id="college_code_update" name="college.code" class="easyui-textbox" data-options="required:true" style="width:172px;"></td>
            </tr>
            <tr>
                <td>学院名称:</td>
                <td>
                    <input id="college_name_update" name="college.name" class="easyui-textbox" data-options="required:true" style="width:172px;">
                    <input type="hidden" id="college_id_update" name="college.id">
                </td>
            </tr>
            <tr>
                <td>学院简称:</td>
                <td><input id="college_shortName_update" name="college.shortName" class="easyui-textbox" style="width:172px;"></td>
            </tr>

            <tr>
                <td>院长:</td>
                <td><input id="college_dean_update" name="college.dean.id" style="width:172px;"></td>
            </tr>

            <tr>
                <td>所属学校:</td>
                <td><input id="college_university_update" name="college.university.id" style="width:172px;"></td>
            </tr>
            <tr>
                <td>学院建立日期:</td>
                <td><input id="college_buildDate_update" class="easyui-datebox" name="college.buildDate" style="width:172px;"></td>
            </tr>
            <tr>
                <td>学院简介:</td>
                <td>
                    <textarea id="college_description_update" name="college.description" rows="10" maxlength="120" class="textbox" style="resize:none;width:160px;white-space:pre-wrap;padding: 5px"></textarea>
                </td>
            </tr>
        </table>

    </form>
</div>


<script type="text/javascript">

    $(function () {
        //根据学院名称查询
        $("#college_search_name").textbox({
            icons: [{
                iconCls:'icon-clear',
                handler: function(e){
                    $(e.data.target).textbox('clear');
                }
            }]
        });

        //查询按钮
        $("#college_search_btn").linkbutton({
            iconCls : 'icon-search',
            onClick : function(){
                $("#collegeGrid").datagrid('load',{
                    'college.name':$("#college_search_name").textbox('getValue'),
                });
            }
        })

        //新增按钮
        $("#college_add_btn").linkbutton({
            iconCls : 'icon-add',
            onClick : function(){
                $("#addCollege_dialog").css("display","block");

                $("#addCollge_form").form('clear');

                //院长
                $("#college_dean_add").combobox({
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
                //所属大学
                $("#college_university_add").combobox({
                    url:'<%=path%>/json/universityAction!getAll',
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
                    modal:true,
                    buttons: [{
                        text: '保存',
                        iconCls: 'icon-ok',
                        handler: function () {
                            $("#addCollge_form").form('submit',{
                                url:'<%=path%>/json/collegeAction!save',
                                success:function(data){
                                    var data = eval('(' + data + ')');
                                    //如果新增成功，做三件事：1.刷新链表，2.提示新增操作成功,3.关闭新增窗口
                                    if(data.result == 'success'){
                                        $.messager.show({
                                            title : '新增学院',
                                            msg : '新增成功!',
                                            timeout : 2000,
                                        });
                                        $("#collegeGrid").datagrid('reload');
                                    }else{
                                        $.messager.alert('新增学院','新增失败。');
                                    }
                                    $("#addCollege_dialog").dialog('close');
                                }
                            })
                        }
                    }, {
                        text: '取消',
                        iconCls: 'icon-cancel',
                        handler: function () {
                            $('#addCollege_dialog').dialog('close');
                        }
                    }],
                });
            }
        })

        //更新按钮
        $("#college_update_btn").linkbutton({
            iconCls : 'icon-edit',
            onClick : function(){
                $("#college_dean_update").combobox({
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

                $("#college_university_update").combobox({
                    url:'<%=path%>/json/universityAction!getAll',
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
                    modal:true,
                    buttons: [{
                        text: '保存',
                        iconCls: 'icon-ok',
                        handler: function () {
                            $("#updateCollege_form").form('submit',{
                                url:'<%=path%>/json/collegeAction!update',
                                success:function(data){
                                    try{
                                        var da = eval('(' + data + ')');
                                        //如果更新成功，做三件事：1.刷新链表，2.提示新增操作成功,3.关闭新增窗口
                                        if (da.result == 'success') {
                                            $.messager.show({
                                                title : '修改学院',
                                                msg : '修改成功!',
                                                timeout : 2000,
                                            });
                                            $("#collegeGrid").datagrid('reload');
                                            $("#updateCollege_dialog").dialog('close');
                                        }
                                    }catch (err){
                                        $.messager.alert('修改学院',data, 'error');
                                    }
                                }
                            })
                        }
                    }, {
                        text: '取消',
                        iconCls: 'icon-cancel',
                        handler: function () {
                            $('#updateCollege_dialog').dialog('close');
                        }
                    }],
                });
                //给各字段赋值
                $("#college_code_update").textbox('setValue',row.code);
                $("#college_name_update").textbox('setValue',row.name);
                $("#college_shortName_update").textbox('setValue',row.shortName);
                $("#college_dean_update").textbox('setValue', row.dean.id);
                $("#college_university_update").combobox('setValue', row.university.id);
                $("#college_buildDate_update").datebox('setValue',row.buildDate);
                $("#college_description_update").textbox('setValue',row.description);

            }
        })

        //删除按钮
        $("#college_remove_btn").linkbutton({
            iconCls : 'icon-remove',
            onClick : function(){
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
                                    $.messager.show({
                                        title : '删除学院',
                                        msg : '删除成功!',
                                        timeout : 2000,
                                    });
                                    $("#collegeGrid").datagrid('reload');
                                }else{
                                    $.messager.alert('删除学院','删除失败。');
                                }
                            }
                        });
                    }
                });

            }
        })

        $("#collegeGrid").datagrid({
            title:'学院管理',
            pagination:true,
            singleSelect:true,
            rownumbers:true,
            fit:true,//此时当点击最外围的layout时整个表格可以自动适应大小
            toolbar:'#college_search',
            url:'<%=path%>/json/collegeAction!list',
            columns: [[
                {field: 'code', title: '学校编号'},
                {field: 'name', title: '学院名称'},
                {field: 'shortName', title: '学院简称'},
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
                        //重点：如果所属学校为空，则value.university便未定义
                        if (row.university) {
                            return row.university.name;
                        } else {
                            return value;
                        }
                    }
                },
                {
                    field: 'buildDate', title: '学院建立时间',
                    formatter : function (value, row, index) {
                        return getDate(value);
                    }
                },
                {field: 'description', title: '学院简介'},
            ]],
            queryParams: {//和查询时发送的请求保持一致
                'college.name': '',
            }
        });
    });

</script>

</body>




</html>