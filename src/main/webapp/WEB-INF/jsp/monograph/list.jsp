<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="/WEB-INF/reuse/path.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>

<table id="monographGrid"></table>

<!-- 查询工具条 -->
<div id="monograph_search">
    专著名称: <input id="monograph_search_name" style="width:100px;">
    <%--先隐去
    专著作者: <input id="monograph_participator_name" style="width:100px;">--%>
    <a id="monograph_search_btn">搜索</a><br/>
    <a id="monograph_add_btn">新增</a>
    <a id="monograph_update_btn">修改</a>
    <a id="monograph_remove_btn">删除</a>
</div>

<div id="add_monograph_dialog" style="display: none;">
    <form id="add_monograph_form" method="post">
        <table cellspacing="10px" style="padding: 5px 5px;">
            <tr>
                <td>专著编号:</td>
            <td><input id="monograph_code_add" name="monograph.code" class="easyui-textbox" data-options="required:true" style="width:172px;"></td>
            </tr>
            
            <tr>
                <td>专著名称:</td>
                <td><input id="monograph_name_add" name="monograph.name" class="easyui-textbox" data-options="required:true" style="width:172px;"></td>
            </tr>

            <tr>
                <td>出版机构:</td>
                <td><input name="monograph.hiredInstitution" class="easyui-textbox" data-options="required:true" style="width:172px;"></td>
            </tr>

            <tr>
                <td>专著类别:</td>
                <td><input id="monograph_level_add" name="monograph.level" style="width:172px;"></td>
            </tr>
            
            <tr>
                <td>出版日期:</td>
                <td><input name="monograph.publishDate" class="easyui-datebox" style="width:172px;"></td>
            </tr>

            <tr>
                <td>作者:</td>
                <td>
                    <input id="monograph_authorSet_add" name="authorIds" class="easyui-textbox" data-options="required:true" style="width:172px;">
                </td>
                <td>支持多选</td>
            </tr>

            <tr>
                <td>备注:</td>
                <td>
                    <textarea id="monograph_remark_add" name="monograph.remark" placeholder="不超过120个字符" rows="5" maxlength="120" class="textbox" style="resize:none;width:160px;white-space:pre-wrap;padding: 5px"></textarea>
                </td>
            </tr>


        </table>
    </form>
</div>

<div id="update_monograph_dialog" style="display: none;">
    <form id="update_monograph_form" method="post">
        <table cellspacing="10px" style="padding: 5px 5px;">
            <tr>
                <td>专著编号:</td>
                <td><input id="monograph_code_update" name="monograph.code" class="easyui-textbox" data-options="required:true" style="width:172px;"></td>
            </tr>
            
            <tr>
                <td>专著名称:</td>
                <td>
                    <input id="monograph_name_update" name="monograph.name" class="easyui-textbox" data-options="required:true" style="width:172px;">
                    <input type="hidden" id="monograph_id_update" name="monograph.id">
                </td>
            </tr>

            <tr>
                <td>出版机构:</td>
                <td><input id="monograph_hiredInstitution_update" name="monograph.hiredInstitution" class="easyui-textbox" data-options="required:true" style="width:172px;"></td>
            </tr>

            <tr>
                <td>专著类别:</td>
                <td><input id="monograph_level_update" name="monograph.level" style="width:172px;"></td>
            </tr>

            <tr>
                <td>出版日期:</td>
                <td><input id="monograph_publishDate_update" name="monograph.publishDate" class="easyui-datebox" style="width:172px;"></td>
            </tr>

            <tr>
                <td>作者:</td>
                <td>
                    <input id="monograph_authorSet_update" name="authorIds" class="easyui-textbox" data-options="required:true" style="width:172px;">
                </td>
                <td>支持多选</td>
            </tr>

            <tr>
                <td>备注:</td>
                <td>
                    <textarea id="monograph_remark_update" name="monograph.remark" placeholder="不超过120个字符" rows="5" maxlength="120" class="textbox" style="resize:none;width:160px;white-space:pre-wrap;padding: 5px"></textarea>
                </td>
            </tr>
        </table>

    </form>
</div>


<script type="text/javascript">

    $(function () {

        //根据专著名称查询
        $("#monograph_search_name").textbox({
            icons: [{
                iconCls:'icon-clear',
                handler: function(e){
                    $(e.data.target).textbox('clear');
                }
            }]
        });

        //查询按钮
        $("#monograph_search_btn").linkbutton({
            iconCls : 'icon-search',
            onClick : function(){
                $("#monographGrid").datagrid('load',{
                    'monograph.name':$("#monograph_search_name").textbox('getValue'),

                });
            }
        })

        //新增按钮
        $("#monograph_add_btn").linkbutton({
            iconCls : 'icon-add',
            onClick : function(){
                $("#add_monograph_dialog").css("display","block");

                $("#add_monograph_form").form('clear');

                //专著作者
                $("#monograph_authorSet_add").combobox({
                    url:'<%=path%>/json/userAction!getAll',
                    valueField:'id',
                    textField:'username',
                    editable:false,
                    multiple : true,
                    icons:[{
                        iconCls:'icon-clear',
                        handler:function(e){
                            $(e.data.target).combobox('clear');
                        }
                    }]
                });

                //专著类别
                $("#monograph_level_add").combobox({
                    url:'<%=path%>/json/dictionaryAction!getTopX',
                    queryParams : {
                        topX : '专著类别',
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

                $("#add_monograph_dialog").dialog({
                    title:'新增出版专著项',
                    modal:true,
                    buttons: [{
                        text: '保存',
                        iconCls: 'icon-ok',
                        handler: function () {
                            $("#add_monograph_form").form('submit',{
                                url:'<%=path%>/json/monographAction!save',
                                success:function(data){
                                    try{
                                        var res = eval('(' + data + ')');
                                        if(res.result == 'success') {
                                            $.messager.show({
                                                title: '新增出版专著',
                                                msg: '新增成功!',
                                                timeout: 2000,
                                            });
                                            $("#monographGrid").datagrid('reload');
                                            $("#add_monograph_dialog").dialog('close');
                                        }
                                    }catch(err){
                                        $.messager.alert('新增出版专著',data, 'error');
                                    }
                                }
                            })
                        }
                    }, {
                        text: '取消',
                        iconCls: 'icon-cancel',
                        handler: function () {
                            $('#add_monograph_dialog').dialog('close');
                        }
                    }],
                });

            }
        })

        //更新按钮
        $("#monograph_update_btn").linkbutton({
            iconCls : 'icon-edit',
            onClick : function(){

                var row = $("#monographGrid").datagrid('getSelected');
                if (row == null) {
                    $.messager.alert("修改出版专著",'请先选中需要修改的项。','info');
                    return false;
                }

                //给id赋值便于传递到后台
                $("#monograph_id_update").val(row.id);

                $("#update_monograph_dialog").css("display","block");

                $("#update_monograph_dialog").dialog({
                    title:'修改专著信息',
                    modal:true,
                    buttons: [{
                        text: '保存',
                        iconCls: 'icon-ok',
                        handler: function () {
                            $("#update_monograph_form").form('submit',{
                                url:'<%=path%>/json/monographAction!update',
                                success:function(data){
                                    $("#update_monograph_dialog").dialog('close');

                                    try{
                                        var res = eval('(' + data + ')');
                                        //如果更新成功，做三件事：1.刷新链表，2.提示新增操作成功,3.关闭新增窗口
                                        if (res.result == 'success') {
                                            $.messager.show({
                                                title : '修改专著',
                                                msg : '修改成功!',
                                                timeout : 2000,
                                            });
                                            $("#monographGrid").datagrid('reload');
                                            $("#update_monograph_dialog").dialog('close');
                                        }
                                    }catch (err){
                                        $.messager.alert('修改专著',data, 'error');
                                    }


                                }
                            })
                        }
                    }, {
                        text: '取消',
                        iconCls: 'icon-cancel',
                        handler: function () {
                            $('#update_monograph_dialog').dialog('close');
                        }
                    }],
                });

                //专著作者
                $("#monograph_authorSet_update").combobox({
                    url:'<%=path%>/json/userAction!getAll',
                    valueField:'id',
                    textField:'username',
                    editable:false,
                    multiple : true,
                    icons:[{
                        iconCls:'icon-clear',
                        handler:function(e){
                            $(e.data.target).combobox('clear');
                        }
                    }]
                });

                //专著类别
                $("#monograph_level_update").combobox({
                    url:'<%=path%>/json/dictionaryAction!getTopX',
                    queryParams : {
                        topX : '专著类别',
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

                //给各字段赋值
                $("#monograph_name_update").textbox('setValue',row.name);
                $("#monograph_code_update").textbox('setValue',row.code);
                $("#monograph_hiredInstitution_update").textbox('setValue',row.hiredInstitution);

                //专著级别
                if(row.level){//只有有值时才赋值，否则使用默认值
                    $("#monograph_level_update").combobox('setValue', row.level);
                }else {
                    var data = $("#monograph_level_update").combobox('getData');
                    if(data.length > 0){
                        $("#monograph_level_update").combobox('setValue', data[0].code);
                    }
                }

                //到会者
                var authorList = row.authorSet;
                var authorIds = "";
                for(var i = 0; i < authorList.length; i++){
                    if (authorIds == ""){
                        authorIds += authorList[i].id;
                    }else {
                        authorIds += "," + authorList[i].id;
                    }
                }
                $("#monograph_authorSet_update").combobox('setValues', authorIds.split(","));

                $("#monograph_publishDate_update").datebox('setValue',row.publishDate);
                $("#monograph_remark_update").val(row.remark);
            }
        })

        //删除按钮
        $("#monograph_remove_btn").linkbutton({
            iconCls : 'icon-remove',
            onClick : function(){
                var row = $("#monographGrid").datagrid('getSelected');
                if (row == null) {
                    $.messager.alert("删除出版专著",'请先选中需要删除的项。','info');
                    return false;
                }
                $.messager.confirm('删除出版专著',"确定删除此条记录吗?",function(flag){
                    if(flag){
                        var id = row.id;
                        $.ajax({
                            url:'<%=path%>/json/monographAction!delete',
                            type:'post',
                            dataType:'json',
                            data:{
                                'monograph.id':row.id
                            },
                            success:function(data){
                                if(data.result == 'success'){
                                    $.messager.show({
                                        title : '删除专著',
                                        msg : '删除成功!',
                                        timeout : 2000,
                                    });
                                    $("#monographGrid").datagrid('reload');
                                }else{
                                    $.messager.alert('删除出版专著','删除失败。');
                                }
                            }
                        });
                    }
                });

            }
        })

        //主体表格
        $("#monographGrid").datagrid({
            title:'出版专著管理',
            pagination:true,
            singleSelect:true,
            rownumbers:true,
            fit:true,
            toolbar:'#monograph_search',
            url:'<%=path%>/json/monographAction!list',
            columns: [[
                {field: 'code', title: '专著编号'},
                {field: 'name', title: '专著名称'},
                {field: 'hiredInstitution', title: '出版机构'},
                {
                    field: 'level', title: '专著类别',
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
                    field: 'publishDate', title: '出版日期',
                    formatter : function (value, row, index) {
                        return getDate(value);
                    }
                },
                {
                    field: 'authorSet', title: '作者者',
                    formatter: function (value, row, index) {
                        var authorStr = "";
                        for(var i = 0; i < value.length; i++){
                            if (authorStr == ""){
                                authorStr += value[i].username;
                            }else {
                                authorStr += " , " + value[i].username;
                            }
                        }
                        return authorStr;
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
                'monograph.name': '',
//                'monograph.authorList[0].username' : '',
            }
        });
    });


</script>

</body>

</html>