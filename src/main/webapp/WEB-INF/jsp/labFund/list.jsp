<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="/WEB-INF/reuse/path.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>

<table id="labFundGrid"></table>

<!-- 查询工具条 -->
<div id="labFund_search">
    经费用途: <input id="labFund_search_name" name="labFund.name" style="width:100px;">
    <a id="labFund_search_btn">搜索</a><br/>
    <a id="labFund_add_btn">新增</a>
    <a id="labFund_update_btn">修改</a>
    <a id="labFund_remove_btn">删除</a>
</div>

<div id="add_LabFund_dialog" style="display: none;">
    <form id="add_LabFund_form" method="post">
        <table cellspacing="15px" style="text-align: right;padding: 5px 5px;">
            <tr>
                <td>经费编号:</td>
                <td><input name="labFund.code" class="easyui-textbox" data-options="required:true" style="width:172px;"></td>
            </tr>
            <tr>
                <td>经费用途:</td>
                <td><input name="labFund.content" class="easyui-textbox" data-options="required:true" style="width:172px;"></td>
            </tr>
            <tr>
                <td>经费数量:</td>
                <td><input name="labFund.totalPrice" class="easyui-numberspinner" style="width:172px;"></td>
            </tr>
            <tr>
                <td>经手人:</td>
                <td><input id="labFund_keeper_add" name="labFund.keeper.id" style="width:172px;"></td>
            </tr>
            <tr>
                <td>实验室:</td>
                <td><input id="labFund_labRoom_add" name="labFund.labRoom.id" style="width:172px;"></td>
            </tr>
            <tr>
                <td>经费类别:</td>
                <td>
                    <input id="labFund_fundType_add" name="labFund.fundType"  class="easyui-textbox" style="width:172px;">
                </td>
            </tr>
            <tr>
                <td>申请日期:</td>
                <td><input class="easyui-datebox" name="labFund.applyDate" style="width:172px;"></td>
            </tr>
            <tr>
                <td>备注:</td>
                <td>
                    <textarea name="labFund.remark" rows="10" class="textbox" style="resize:none;width:160px;white-space:pre-wrap;padding: 5px"></textarea>
                </td>
            </tr>
        </table>

    </form>
</div>

<div id="update_LabFund_dialog" style="display: none;">
    <form id="update_LabFund_form" method="post">
        <table cellspacing="15px" style="text-align: right;padding: 5px 5px;">
            <tr>
                <td>经费编号:</td>
                <td><input id="labFund_code_update" name="labFund.code" class="easyui-textbox" data-options="required:true" style="width:172px;"></td>
            </tr>
            <tr>
                <td>经费用途:</td>
                <td>
                    <input id="labFund_content_update" name="labFund.content" class="easyui-textbox" data-options="required:true" style="width:172px;">
                    <input type="hidden" id="labFund_id_update" name="labFund.id">
                </td>
            </tr>
            <tr>
                <td>经费数量:</td>
                <td><input id="labFund_totalPrice_update" name="labFund.totalPrice" class="easyui-numberspinner" style="width:172px;"></td>
            </tr>
            <tr>
                <td>经手人:</td>
                <td><input id="labFund_keeper_update" name="labFund.keeper.id" style="width:172px;"></td>
            </tr>
            <tr>
                <td>实验室:</td>
                <td><input id="labFund_labRoom_update" name="labFund.labRoom.id" style="width:172px;"></td>
            </tr>
            <tr>
                <td>经费类别:</td>
                <td>
                    <input id="labFund_fundType_update" name="labFund.fundType"  class="easyui-textbox" style="width:172px;">
                </td>
            </tr>
            <tr>
                <td>申请日期:</td>
                <td><input id="labFund_applyDate_update" class="easyui-datebox" name="labFund.applyDate" style="width:172px;"></td>
            </tr>
            <tr>
                <td>备注:</td>
                <td>
                    <textarea id="labFund_remark_update" name="labFund.remark" rows="10" class="textbox" style="resize:none;width:160px;white-space:pre-wrap;padding: 5px"></textarea>
                </td>
            </tr>
        </table>

    </form>
</div>

<script type="text/javascript">

    $(function () {

        //根据经费用途查询
        $("#labFund_search_name").textbox({
            icons: [{
                iconCls:'icon-clear',
                handler: function(e){
                    $(e.data.target).textbox('clear');
                }
            }]
        });

        //查询按钮
        $("#labFund_search_btn").linkbutton({
            iconCls : 'icon-search',
            onClick : function(){
                $("#labFundGrid").datagrid('load',{
                    'labFund.content':$("#labFund_search_name").textbox('getValue'),
                });
            }
        })

        //新增按钮
        $("#labFund_add_btn").linkbutton({
            iconCls : 'icon-add',
            onClick : function(){
                $("#add_LabFund_dialog").css("display","block");
                $("#add_LabFund_form").form('clear');

                //培训类别
                $("#labFund_fundType_add").combobox({
                    url:'<%=path%>/json/dictionaryAction!getTopX',
                    queryParams : {
                        topX : '经费类别',
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
                        var data = $("#labFund_fundType_add").combobox('getData');
                        if(data.length > 0){
                            $("#labFund_fundType_add").combobox('setValue', data[0].code);
                        }
                    }
                });

                //经手人
                $("#labFund_keeper_add").combobox({
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

                //哪个实验室的经费
                $("#labFund_labRoom_add").combobox({
                    url:'<%=path%>/json/labRoomAction!getAll',
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

                $("#add_LabFund_dialog").dialog({
                    title:'新增经费项',
                    modal:true,
                    buttons: [{
                        text: '保存',
                        iconCls: 'icon-ok',
                        handler: function () {
                            $("#add_LabFund_form").form('submit',{
                                url:'<%=path%>/json/labFundAction!save',
                                success:function(data){
                                    try{
                                        var res = eval('(' + data + ')');
                                        if(res.result == 'success') {
                                            $.messager.show({
                                                title: '新增经费',
                                                msg: '新增成功!',
                                                timeout: 2000,
                                            });
                                            $("#labFundGrid").datagrid('reload');
                                            $("#add_LabFund_dialog").dialog('close');
                                        }
                                    }catch(err){
                                        $.messager.alert('新增经费',data, 'error');
                                    }
                                }
                            });
                        }
                    }, {
                        text: '取消',
                        iconCls: 'icon-cancel',
                        handler: function () {
                            $('#add_LabFund_dialog').dialog('close');
                        }
                    }],
                });

            }
        })

        //更新按钮
        $("#labFund_update_btn").linkbutton({
            iconCls : 'icon-edit',
            onClick : function(){
                var row = $("#labFundGrid").datagrid('getSelected');
                if (row == null) {
                    $.messager.alert("修改经费项",'请先选中需要修改的项。','info');
                    return false;
                }

                //经费类别
                $("#labFund_fundType_update").combobox({
                    url:'<%=path%>/json/dictionaryAction!getTopX',
                    queryParams : {
                        topX : '经费类别',
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

                //经手人
                $("#labFund_keeper_update").combobox({
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

                //哪个实验室的经费
                $("#labFund_labRoom_update").combobox({
                    url:'<%=path%>/json/labRoomAction!getAll',
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

                //给id赋值便于传递到后台
                $("#labFund_id_update").val(row.id);

                $("#update_LabFund_dialog").css("display","block");

                $("#update_LabFund_dialog").dialog({
                    title:'修改经费信息',
                    modal:true,
                    buttons: [{
                        text: '保存',
                        iconCls: 'icon-ok',
                        handler: function () {
                            $("#update_LabFund_form").form('submit',{
                                url:'<%=path%>/json/labFundAction!update',
                                success:function(data){
                                    try{
                                        var res = eval('(' + data + ')');
                                        //如果更新成功，做三件事：1.刷新链表，2.提示新增操作成功,3.关闭新增窗口
                                        if (res.result == 'success') {
                                            $.messager.show({
                                                title : '修改经费',
                                                msg : '修改成功!',
                                                timeout : 2000,
                                            });
                                            $("#labFundGrid").datagrid('reload');
                                            $("#update_LabFund_dialog").dialog('close');
                                        }
                                    }catch (err){
                                        $.messager.alert('修改经费',data, 'error');
                                    }

                                }
                            })
                        }
                    }, {
                        text: '取消',
                        iconCls: 'icon-cancel',
                        handler: function () {
                            $('#update_LabFund_dialog').dialog('close');
                        }
                    }],
                });
                //给各字段赋值
                $("#labFund_code_update").textbox('setValue',row.code);
                $("#labFund_content_update").textbox('setValue',row.content);
                $("#labFund_fundType_update").combobox('setValue',row.fundType);
                $("#labFund_totalPrice_update").numberspinner('setValue', row.totalPrice);
                $("#labFund_keeper_update").combobox('setValue', row.keeper.id);
                $("#labFund_labRoom_update").combobox('setValue', row.labRoom.id);
                $("#labFund_applyDate_update").datebox('setValue',row.applyDate);
                $("#labFund_remark_update").val(row.remark);

            }
        })

        //删除按钮
        $("#labFund_remove_btn").linkbutton({
            iconCls : 'icon-remove',
            onClick : function(){
                var row = $("#labFundGrid").datagrid('getSelected');
                if (row == null) {
                    $.messager.alert("删除经费",'请先选中需要删除的项。','info');
                    return false;
                }
                $.messager.confirm('删除经费',"确定删除此条记录吗?",function(flag){
                    if(flag){
                        var id = row.id;
                        $.ajax({
                            url:'<%=path%>/json/labFundAction!delete',
                            type:'post',
                            dataType:'json',
                            data:{
                                'labFund.id':row.id
                            },
                            success:function(data){
                                if(data.result == 'success'){
                                    $.messager.show({
                                        title : '删除经费',
                                        msg : '删除成功!',
                                        timeout : 2000,
                                    });
                                    $("#labFundGrid").datagrid('reload');
                                }else{
                                    $.messager.alert('删除经费','删除失败。');
                                }
                            }
                        });
                    }
                });

            }
        })
    });

    //主体表格
    $("#labFundGrid").datagrid({
        title:'经费管理',
        pagination:true,
        singleSelect:true,
        rownumbers:true,
        fit:true,//此时当点击最外围的layout时整个表格可以自动适应大小
        toolbar:'#labFund_search',
        url:'<%=path%>/json/labFundAction!list',
        columns: [[
            {field: 'code', title: '经费编号'},
            {field: 'content', title: '经费用途'},
            {field: 'totalPrice', title: '经费数量'},
            {
                field: 'keeper', title: '负责人',
                formatter: function (value, row, index) {
                    if (row.keeper) {
                        return row.keeper.username;
                    } else {
                        return value;
                    }
                }
            },
            {
                field: 'labRoom', title: '实验室',
                formatter: function (value, row, index) {
                    if (row.labRoom) {
                        return row.labRoom.name;
                    } else {
                        return value;
                    }
                }
            },
            {
                field: 'fundType', title: '经费类别',
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
                field: 'applyDate', title: '申请日期',
                formatter : function (value, row, index) {
                    return getDate(value);
                }
            },
            {field: 'remark', title: '备注'},
        ]],
        queryParams: {//和查询时发送的请求保持一致
            'labFund.content': '',
        }
    });




</script>

</body>
</html>