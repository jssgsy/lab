<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="/WEB-INF/reuse/path.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>

<table id="paperGrid"></table>

<!-- 查询工具条 -->
<div id="paper_search">
    论文名称: <input id="paper_search_name" name="labRoom.name" style="width:100px;">
    <a id="paper_search_btn">搜索</a><br/>
    <a id="paper_add_btn">新增</a>
    <a id="paper_update_btn">修改</a>
    <a id="paper_remove_btn">删除</a>
</div>

<div id="addPaper_dialog" style="display: none;">
    <form id="addPaper_form" method="post">
        <table cellspacing="10px" style="padding: 5px 5px;">
            <tr>
                <td>论文名称:</td>
                <td><input id="paper_name_add" name="paper.name" class="easyui-textbox" data-options="required:true" style="width:172px;"></td>
            </tr>

            <tr>
                <td>论文作者:</td>
                <td>
                    <input id="paper_author_add" name="authorIds" class="easyui-textbox" data-options="required:true" style="width:172px;">
                </td>
                <td>支持多选</td>
            </tr>

            <tr>
                <td>录用机构:</td>
                <td><input id="paper_hiredInstitution_add" name="paper.hiredInstitution" class="easyui-textbox" data-options="required:true" style="width:172px;"></td>
            </tr>

            <tr>
                <td>论文级别:</td>
                <td><input id="paper_level_add" name="paper.level" style="width:172px;"></td>
            </tr>

            <tr>
                <td>是否SCI:</td>
                <td>
                    <input type="radio" name="paper.wasSCI" value="true">是
                    <input type="radio" name="paper.wasSCI" value="false">否
                </td>
            </tr>

            <tr>
                <td>发表日期:</td><!--这里使用datebox的默认值即可-->
                <td><input id="paper_publishDate_add" class="easyui-datebox" name="paper.publishDate" style="width:172px;"></td>
            </tr>

            <tr>
                <td>备注:</td>
                <td>
                    <textarea id="paper_remark_add" name="paper.remark" placeholder="不超过120个字符" rows="5" maxlength="120" class="textbox" style="resize:none;width:160px;white-space:pre-wrap;padding: 5px"></textarea>
                </td>
            </tr>


        </table>
    </form>
</div>

<div id="updatepaper_dialog" style="display: none;">
    <form id="updatepaper_form" method="post">
        <table cellspacing="10px" style="padding: 5px 5px;">
            <tr>
                <td>科研论文名称:</td>
                <td>
                    <input id="paper_name_update" name="paper.name" class="easyui-textbox" data-options="required:true" style="width:172px;">
                    <input type="hidden" id="paper_id_update" name="paper.id">
                </td>
            </tr>
            <tr>
                <td>论文作者:</td>
                <td>
                    <input id="paper_authorList_update" name="authorIds" class="easyui-textbox" data-options="required:true" style="width:172px;">
                </td>
                <td>支持多选</td>
            </tr>

            <tr>
                <td>录用机构:</td>
                <td><input id="paper_hiredInstitution_update" name="paper.hiredInstitution" class="easyui-textbox" data-options="required:true" style="width:172px;"></td>
            </tr>

            <tr>
                <td>论文级别:</td>
                <td><input id="paper_level_update" name="paper.level" style="width:172px;"></td>
            </tr>

            <tr>
                <td>是否SCI:</td>
                <td>
                    <input type="radio" id="paper_wasSCI_update_Yes" name="paper.wasSCI" value="true">是
                    <input type="radio" id="paper_wasSCI_update_No" name="paper.wasSCI" value="false">否
                </td>
            </tr>

            <tr>
                <td>发表日期:</td><!--这里使用datebox的默认值即可-->
                <td><input id="paper_publishDate_update" class="easyui-datebox" name="paper.publishDate" style="width:172px;"></td>
            </tr>

            <tr>
                <td>备注:</td>
                <td>
                    <textarea id="paper_remark_update" name="paper.remark" placeholder="不超过120个字符" rows="5" maxlength="120" class="textbox" style="resize:none;width:160px;white-space:pre-wrap;padding: 5px"></textarea>
                </td>
            </tr>
        </table>

    </form>
</div>


<script type="text/javascript">

    $(function () {

        //根据科研论文名称查询,todo:还需要增加一个根据作者名查
        $("#paper_search_name").textbox({
            icons: [{
                iconCls:'icon-clear',
                handler: function(e){
                    $(e.data.target).textbox('clear');
                }
            }]
        });

        //查询按钮
        $("#paper_search_btn").linkbutton({
            iconCls : 'icon-search',
            onClick : function(){
                $("#paperGrid").datagrid('load',{
                    'paper.name':$("#paper_search_name").textbox('getValue'),
                });
            }
        })

        //新增按钮
        $("#paper_add_btn").linkbutton({
            iconCls : 'icon-add',
            onClick : function(){
                $("#addPaper_dialog").css("display","block");

                $("#addPaper_form").form('clear');

                //todo:看新增与更新能不能共用，似乎多发了无用的请求
                //第一作者
                $("#paper_author_add").combobox({
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

                //论文级别
                $("#paper_level_add").combobox({
                    url:'<%=path%>/json/dictionaryAction!getTopX',
                    queryParams : {
                        topX : '论文级别',
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
                        var data = $("#paper_level_add").combobox('getData');
                        if(data.length > 0){
                            $("#paper_level_add").combobox('setValue', data[0].code);
                        }
                    }
                });

                $("#addPaper_dialog").dialog({
                    title:'新增科研论文项',
                    modal:true,
                    buttons: [{
                        text: '保存',
                        iconCls: 'icon-ok',
                        handler: function () {
                            $("#addPaper_form").form('submit',{
                                url:'<%=path%>/json/paperAction!save',
                                success:function(data){
                                    var data = eval('(' + data + ')');
                                    //如果新增成功，做三件事：1.刷新链表，2.提示新增操作成功,3.关闭新增窗口
                                    if(data.result == 'success'){
                                        $.messager.show({
                                            title : '新增科研论文',
                                            msg : '新增成功!',
                                            timeout : 2000,
                                        });
                                        $("#paperGrid").datagrid('reload');
                                    }else{
                                        $.messager.alert('新增科研论文','新增失败。');
                                    }
                                    $("#addPaper_dialog").dialog('close');
                                }
                            })
                        }
                    }, {
                        text: '取消',
                        iconCls: 'icon-cancel',
                        handler: function () {
                            $('#addPaper_dialog').dialog('close');
                        }
                    }],
                });

            }
        })

        //更新按钮
        $("#paper_update_btn").linkbutton({
            iconCls : 'icon-edit',
            onClick : function(){
                $("#paper_authorList_update").combobox({
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

                //论文级别
                $("#paper_level_update").combobox({
                    url:'<%=path%>/json/dictionaryAction!getTopX',
                    queryParams : {
                        topX : '论文级别',
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

                var row = $("#paperGrid").datagrid('getSelected');
                if (row == null) {
                    $.messager.alert("修改论文",'请先选中需要修改的项。','info');
                    return false;
                }

                //给id赋值便于传递到后台
                $("#paper_id_update").val(row.id);

                $("#updatepaper_dialog").css("display","block");

                $("#updatepaper_dialog").dialog({
                    title:'修改科研论文信息',
                    modal:true,
                    buttons: [{
                        text: '保存',
                        iconCls: 'icon-ok',
                        handler: function () {
                            $("#updatepaper_form").form('submit',{
                                url:'<%=path%>/json/paperAction!update',
                                success:function(data){
                                    var data = eval('(' + data + ')');
                                    //如果更新成功，做三件事：1.刷新链表，2.提示新增操作成功,3.关闭新增窗口
                                    if (data.result == 'success') {
                                        $.messager.show({
                                            title : '修改科研论文',
                                            msg : '修改成功!',
                                            timeout : 2000,
                                        });
                                        $("#paperGrid").datagrid('reload');
                                    } else {
                                        $.messager.alert('修改科研论文','修改失败。');
                                    }
                                    $("#updatepaper_dialog").dialog('close');
                                }
                            })
                        }
                    }, {
                        text: '取消',
                        iconCls: 'icon-cancel',
                        handler: function () {
                            $('#updatepaper_dialog').dialog('close');
                        }
                    }],
                });
                //给各字段赋值
                $("#paper_name_update").textbox('setValue',row.name);

                var authorList = row.authorList;
                console.log(authorList);
                var authorIds = "";
                for(var i = 0; i < authorList.length; i++){
                    if (authorIds == ""){
                        authorIds += authorList[i].id;
                    }else {
                        authorIds += "," + authorList[i].id;
                    }
                }
                $("#paper_authorList_update").combobox('setValues', authorIds.split(","));

                $("#paper_hiredInstitution_update").textbox('setValue', row.hiredInstitution);
                $("#paper_level_update").combobox('setValue', row.level);

                if(row.wasSCI){
                    $("#paper_wasSCI_update_Yes").attr("checked",true);
                }else{
                    $("#paper_wasSCI_update_No").attr("checked",true);
                }

                $("#paper_publishDate_update").datebox('setValue', row.publishDate);
                $("#paper_remark_update").val(row.remark);
            }
        })

        //删除按钮
        $("#paper_remove_btn").linkbutton({
            iconCls : 'icon-remove',
            onClick : function(){
                var row = $("#paperGrid").datagrid('getSelected');
                if (row == null) {
                    $.messager.alert("删除科研论文",'请先选中需要删除的项。','info');
                    return false;
                }
                $.messager.confirm('删除科研论文',"确定删除此条记录吗?",function(flag){
                    if(flag){
                        var id = row.id;
                        $.ajax({
                            url:'<%=path%>/json/paperAction!delete',
                            type:'post',
                            dataType:'json',
                            data:{
                                'paper.id':row.id
                            },
                            success:function(data){
                                if(data.result == 'success'){
                                    $.messager.show({
                                        title : '删除科研论文',
                                        msg : '删除成功!',
                                        timeout : 2000,
                                    });
                                    $("#paperGrid").datagrid('reload');
                                }else{
                                    $.messager.alert('删除科研论文','删除失败。');
                                }
                            }
                        });
                    }
                });

            }
        })

        //主体表格
        $("#paperGrid").datagrid({
            title:'科研论文管理',
            pagination:true,
            singleSelect:true,
            rownumbers:true,
            fit:true,
            toolbar:'#paper_search',
            url:'<%=path%>/json/paperAction!list',
            columns: [[
                {field: 'name', title: '论文名称'},
                {
                    field: 'authorList', title: '论文作者',
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
                {field: 'hiredInstitution', title: '录用机构'},
                {
                    field: 'level', title: '论文级别',
                    formatter: function (value, row, index) {
                        switch (value){
                            case 0 :
                                return "国际期刊"
                            case 1 :
                                return "国家期刊";
                            case 2 :
                                return "省级期刊";
                            case 3 :
                                return "校级期刊";
                        }
                    }
                },
                {
                    field: 'wasSCI', title: '是否SCI',
                    formatter : function (value, row, index) {
                        if (value){
                            return "是";
                        }else {
                            return "否";
                        }
                    }
                },
                {
                    field: 'publishDate', title: '发表日期',
                    formatter : function (value, row, index) {
                        if(value){
                            var date = new Date(value);
                            return date.getFullYear() + "-" + date.getMonth() + "-" + date.getDate();
                        }
                    }
                },
                {field: 'remark', title: '备注', width: '80px'},
            ]],
            queryParams: {//和查询时发送的请求保持一致
                'paper.name': '',
            }
        });
    });


</script>

</body>

</html>