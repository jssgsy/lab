<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="/WEB-INF/reuse/path.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>

<table id="trainingGrid"></table>

<!-- 查询工具条 -->
<div id="training_search">
    培训名: <input id="training_search_name" name="training.name" style="width:100px;">
    <a id="training_search_btn">搜索</a><br/>
    <a id="training_add_btn">新增</a>
    <a id="training_update_btn">修改</a>
    <a id="training_remove_btn">删除</a>

</div>

<div id="add_training_dialog" style="display: none;">
    <form id="add_training_form" method="post">
        <table cellspacing="15px" style="text-align: right;padding: 5px 5px;">
            <tr>
                <td>培训编号:</td>
                <td><input name="training.code" class="easyui-textbox" data-options="required:true" style="width:172px;"></td>
            </tr>
            <tr>
                <td>培训名称:</td>
                <td><input name="training.name" class="easyui-textbox" data-options="required:true" style="width:172px;"></td>
            </tr>
            <tr>
                <td>培训内容:</td>
                <td><input name="training.content" class="easyui-textbox" style="width:172px;"></td>
            </tr>

            <tr>
                <td>培训类别:</td>
                <td><input id="training_trainingType_add" name="training.trainingType" style="width:172px;"></td>
            </tr>

            <tr>
                <td>培训人:</td>
                <td><input id="training_user_add" name="training.user.id" style="width:172px;"></td>
            </tr>
            <tr>
                <td>培训地址:</td>
                <td>
                    <input name="training.address" class="easyui-textbox" style="width:172px;">
                </td>
            </tr>

            <tr>
                <td>培训小结:</td>
                <td>
                    <input name="training.summary" class="easyui-textbox" style="width:172px;">
                </td>
            </tr>

            <tr>
                <td>培训日期:</td>
                <td><input class="easyui-datebox" name="training.trainingDate" style="width:172px;"></td>
            </tr>

            <%--todo:默认新增应为待审核，且不允许更新，在管理员页面提供审核通过按钮--%>
            <%--<tr>
                <td>审核状态:</td>
                <td>
                    <input type="radio" name="training.wasVerified" value="true">审核通过
                    <input type="radio" name="training.wasVerified" value="false">待审核
                </td>
            </tr>--%>

            <tr>
                <td>备注:</td>
                <td>
                    <textarea name="training.remark" rows="10" class="textbox" style="resize:none;width:160px;white-space:pre-wrap;padding: 5px"></textarea>
                </td>
            </tr>
        </table>

    </form>
</div>

<div id="update_training_dialog" style="display: none;">
    <form id="update_training_form" method="post">
        <table cellspacing="15px" style="text-align: right;padding: 5px 5px;">
            <tr>
                <td>培训编号:</td>
                <td><input id="training_code_update" name="training.code" class="easyui-textbox" data-options="required:true" style="width:172px;"></td>
            </tr>
            <tr>
                <td>培训名称:</td>
                <td><input id="training_name_update" name="training.name" class="easyui-textbox" data-options="required:true" style="width:172px;"></td>
                <input type="hidden" id="training_id_update" name="training.id">

            </tr>
            <tr>
                <td>培训内容:</td>
                <td><input id="training_content_update" name="training.content" class="easyui-textbox" style="width:172px;"></td>
            </tr>

            <tr>
                <td>培训类别:</td>
                <td><input id="training_trainingType_update" name="training.trainingType" style="width:172px;"></td>
            </tr>

            <tr>
                <td>培训人:</td>
                <td><input id="training_user_update" name="training.user.id" style="width:172px;"></td>
            </tr>
            <tr>
                <td>培训地址:</td>
                <td>
                    <input id="training_address_update" name="training.address" class="easyui-textbox" style="width:172px;">
                </td>
            </tr>

            <tr>
                <td>培训小结:</td>
                <td>
                    <input id="training_summary_update" name="training.summary" class="easyui-textbox" style="width:172px;">
                </td>
            </tr>

            <tr>
                <td>培训日期:</td>
                <td><input id="training_trainingDate_update" class="easyui-datebox" name="training.trainingDate" style="width:172px;"></td>
            </tr>

            <tr>
                <td>备注:</td>
                <td>
                    <textarea id="training_remark_update" name="training.remark" rows="10" class="textbox" style="resize:none;width:160px;white-space:pre-wrap;padding: 5px"></textarea>
                </td>
            </tr>
        </table>

    </form>
</div>

<script type="text/javascript">

    $(function () {

        //根据培训名查询
        $("#training_search_name").textbox({
            icons: [{
                iconCls:'icon-clear',
                handler: function(e){
                    $(e.data.target).textbox('clear');
                }
            }]
        });

        //查询按钮
        $("#training_search_btn").linkbutton({
            iconCls : 'icon-search',
            onClick : function(){
                $("#trainingGrid").datagrid('load',{
                    'training.name':$("#training_search_name").textbox('getValue'),
                });
            }
        })

        //新增按钮
        $("#training_add_btn").linkbutton({
            iconCls : 'icon-add',
            onClick : function(){
                $("#add_training_dialog").css("display","block");
                $("#add_training_form").form('clear');

                //培训类别
                $("#training_trainingType_add").combobox({
                    url:'<%=path%>/json/dictionaryAction!getTopX',
                    queryParams : {
                        topX : '培训类别',
                    },
                    valueField:'id',
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
                        var data = $("#training_trainingType_add").combobox('getData');
                        if(data.length > 0){
                            $("#training_trainingType_add").combobox('setValue', data[0].code);
                        }
                    }
                });

                //培训人
                $("#training_user_add").combobox({
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

                $("#add_training_dialog").dialog({
                    title:'新增培训项',
                    modal:true,
                    buttons: [{
                        text: '保存',
                        iconCls: 'icon-ok',
                        handler: function () {
                            $("#add_training_form").form('submit',{
                                url:'<%=path%>/json/trainingAction!save',
                                success:function(data){
                                    try{
                                        var res = eval('(' + data + ')');
                                        if(res.result == 'success') {
                                            $.messager.show({
                                                title: '新增培训',
                                                msg: '新增成功!',
                                                timeout: 2000,
                                            });
                                            $("#trainingGrid").datagrid('reload');
                                            $("#add_training_dialog").dialog('close');
                                        }
                                    }catch(err){
                                        $.messager.alert('新增培训',data, 'error');
                                    }
                                }
                            });
                        }
                    }, {
                        text: '取消',
                        iconCls: 'icon-cancel',
                        handler: function () {
                            $('#add_training_dialog').dialog('close');
                        }
                    }],
                });

            }
        })

        //更新按钮
        $("#training_update_btn").linkbutton({
            iconCls : 'icon-edit',
            onClick : function(){
                //培训人
                $("#training_user_update").combobox({
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

                //培训类别
                $("#training_trainingType_update").combobox({
                    url:'<%=path%>/json/dictionaryAction!getTopX',
                    queryParams : {
                        topX : '培训类别',
                    },
                    valueField:'id',
                    textField:'name',
                    panelHeight : true,
                    editable:false,
                    icons:[{
                        iconCls:'icon-clear',
                        handler:function(e){
                            $(e.data.target).combobox('clear');
                        }
                    }],
                });

                var row = $("#trainingGrid").datagrid('getSelected');
                if (row == null) {
                    $.messager.alert("修改培训记录项",'请先选中需要修改的项。','info');
                    return false;
                }

                //给id赋值便于传递到后台
                $("#training_id_update").val(row.id);

                $("#update_training_dialog").css("display","block");

                $("#update_training_dialog").dialog({
                    title:'修改培训信息',
                    modal:true,
                    buttons: [{
                        text: '保存',
                        iconCls: 'icon-ok',
                        handler: function () {
                            $("#update_training_form").form('submit',{
                                url:'<%=path%>/json/trainingAction!update',
                                success:function(data){
                                    try{
                                        var res = eval('(' + data + ')');
                                        //如果更新成功，做三件事：1.刷新链表，2.提示新增操作成功,3.关闭新增窗口
                                        if (res.result == 'success') {
                                            $.messager.show({
                                                title : '修改培训',
                                                msg : '修改成功!',
                                                timeout : 2000,
                                            });
                                            $("#trainingGrid").datagrid('reload');
                                            $("#update_training_dialog").dialog('close');
                                        }
                                    }catch (err){
                                        $.messager.alert('修改培训',data, 'error');
                                    }

                                }
                            })
                        }
                    }, {
                        text: '取消',
                        iconCls: 'icon-cancel',
                        handler: function () {
                            $('#update_training_dialog').dialog('close');
                        }
                    }],
                });
                //给各字段赋值
                $("#training_code_update").textbox('setValue',row.code);
                $("#training_name_update").textbox('setValue',row.name);
                $("#training_content_update").textbox('setValue',row.content);
                $("#training_address_update").textbox('setValue', row.address);

                //培训类别
                if(row.trainingType){//只有有值时才赋值，否则使用默认值
                    $("#training_trainingType_update").combobox('setValue', row.trainingType);
                }else {
                    var data = $("#training_trainingType_update").combobox('getData');
                    if(data.length > 0){
                        $("#training_trainingType_update").combobox('setValue', data[0].code);
                    }
                }

                $("#training_user_update").combobox('setValue', row.user.id);
                $("#training_trainingDate_update").datebox('setValue',row.trainingDate);
                $("#training_summary_update").textbox('setValue',row.summary);
                $("#training_remark_update").val(row.remark);

            }
        })

        //删除按钮
        $("#training_remove_btn").linkbutton({
            iconCls : 'icon-remove',
            onClick : function(){
                var row = $("#trainingGrid").datagrid('getSelected');
                if (row == null) {
                    $.messager.alert("删除培训",'请先选中需要删除的项。','info');
                    return false;
                }
                $.messager.confirm('删除培训',"确定删除此条记录吗?",function(flag){
                    if(flag){
                        var id = row.id;
                        $.ajax({
                            url:'<%=path%>/json/trainingAction!delete',
                            type:'post',
                            dataType:'json',
                            data:{
                                'training.id':row.id
                            },
                            success:function(data){
                                if(data.result == 'success'){
                                    $.messager.show({
                                        title : '删除培训',
                                        msg : '删除成功!',
                                        timeout : 2000,
                                    });
                                    $("#trainingGrid").datagrid('reload');
                                }else{
                                    $.messager.alert('删除培训','删除失败。');
                                }
                            }
                        });
                    }
                });

            }
        })
    });

    //主体表格
    $("#trainingGrid").datagrid({
        title:'培训管理',
        pagination:true,
        singleSelect:true,
        rownumbers:true,
        fit:true,//此时当点击最外围的layout时整个表格可以自动适应大小
        toolbar:'#training_search',
        url:'<%=path%>/json/trainingAction!list',
        columns: [[
            {field: 'code', title: '培训编号'},
            {field: 'name', title: '培训名称'},
            {field: 'content', title: '培训内容'},
            {
                field: 'trainingType', title: '培训类别',
                formatter: function (value, row, index) {
                     $.ajax({
                        url:'<%=path%>/json/dictionaryAction!getById',
                        type:'post',
                        async: false,
                        dataType:'json',
                        data:{
                            'dictionary.id':value
                        },
                        success:function(data){
                            value =  data.result;
                        }
                    });
                    return value;
                }
            },
            {
                field: 'user', title: '培训人',
                formatter: function (value, row, index) {
                    if (row.user) {
                        return row.user.username;
                    } else {
                        return value;
                    }
                }
            },
            {field: 'address', title: '培训地址'},
            {field: 'summary', title: '培训小结'},
            {
                field: 'trainingDate', title: '培训日期',
                formatter : function (value, row, index) {
                    return getDate(value);
                }
            },
            {field: 'remark', title: '备注'},
            {
                field: 'wasVerified', title: '审核状态',
                formatter : function (value, row, index) {
                    if (value){
                        return "审核通过";
                    }else {
                        return "待审核";
                    }
                }
            },
        ]],
        queryParams: {//和查询时发送的请求保持一致
            'training.name': '',
        }
    });

</script>

</body>
</html>