<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="/WEB-INF/reuse/path.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>

<table id="conferenceGrid"></table>

<!-- 查询工具条 -->
<div id="conference_search">
    会议名称: <input id="conference_search_name" style="width:100px;">
    <%--先隐去
    会议作者: <input id="conference_participator_name" style="width:100px;">--%>
    <a id="conference_search_btn">搜索</a><br/>
    <a id="conference_add_btn">新增</a>
    <a id="conference_update_btn">修改</a>
    <a id="conference_remove_btn">删除</a>
</div>

<div id="add_conference_dialog" style="display: none;">
    <form id="add_conference_form" method="post">
        <table cellspacing="10px" style="padding: 5px 5px;">
            <tr>
                <td>会议编号:</td>
            <td><input id="conference_code_add" name="conference.code" class="easyui-textbox" data-options="required:true" style="width:172px;"></td>
            </tr>
            
            <tr>
                <td>会议名称:</td>
                <td><input id="conference_name_add" name="conference.name" class="easyui-textbox" data-options="required:true" style="width:172px;"></td>
            </tr>

            <tr>
                <td>主持人:</td>
                <td><input id="conference_host_add" name="conference.host.id" class="easyui-textbox" data-options="required:true" style="width:172px;"></td>
            </tr>

            <tr>
                <td>会议内容:</td>
                <td>
                    <textarea id="conference_content_add" name="conference.content" rows="5" maxlength="120" class="textbox" style="resize:none;width:160px;white-space:pre-wrap;padding: 5px"></textarea>
                </td>
            </tr>

            <tr>
                <td>会议地址:</td>
                <td><input id="conference_address_add" name="conference.address" class="easyui-textbox" style="width:172px;"></td>
            </tr>

            <tr>
                <td>应到人数:</td>
                <td><input id="conference_shouldArrivalNum_add" name="conference.shouldArrivalNum" class="easyui-numberspinner" style="width:172px;"></td>
            </tr>

            <tr>
                <td>实到人数:</td>
                <td><input id="conference_actualArrivalNum_add" name="conference.actualArrivalNum" class="easyui-numberspinner" style="width:172px;"></td>
            </tr>

            <tr>
                <td>开会日期:</td>
                <td><input id="conference_conferenceDate_add" name="conference.conferenceDate" class="easyui-datebox" style="width:172px;"></td>
            </tr>

            <tr>
                <td>到会者:</td>
                <td>
                    <input id="conference_participatorSet_add" name="participatorIds" class="easyui-textbox" data-options="required:true" style="width:172px;">
                </td>
                <td>支持多选</td>
            </tr>

            <tr>
                <td>备注:</td>
                <td>
                    <textarea id="conference_remark_add" name="conference.remark" placeholder="不超过120个字符" rows="5" maxlength="120" class="textbox" style="resize:none;width:160px;white-space:pre-wrap;padding: 5px"></textarea>
                </td>
            </tr>


        </table>
    </form>
</div>

<div id="update_conference_dialog" style="display: none;">
    <form id="update_conference_form" method="post">
        <table cellspacing="10px" style="padding: 5px 5px;">
            <tr>
                <td>会议编号:</td>
                <td><input id="conference_code_update" name="conference.code" class="easyui-textbox" data-options="required:true" style="width:172px;"></td>
            </tr>
            
            <tr>
                <td>会议名称:</td>
                <td>
                    <input id="conference_name_update" name="conference.name" class="easyui-textbox" data-options="required:true" style="width:172px;">
                    <input type="hidden" id="conference_id_update" name="conference.id">
                </td>
            </tr>

            <tr>
                <td>主持人:</td>
                <td><input id="conference_host_update" name="conference.host.id" class="easyui-textbox" data-options="required:true" style="width:172px;"></td>
            </tr>

            <tr>
                <td>会议内容:</td>
                <td>
                    <textarea id="conference_content_update" name="conference.content" rows="5" maxlength="120" class="textbox" style="resize:none;width:160px;white-space:pre-wrap;padding: 5px"></textarea>
                </td>
            </tr>

            <tr>
                <td>会议地址:</td>
                <td><input id="conference_address_update" name="conference.address" class="easyui-textbox" style="width:172px;"></td>
            </tr>

            <tr>
                <td>应到人数:</td>
                <td><input id="conference_shouldArrivalNum_update" name="conference.shouldArrivalNum" class="easyui-numberspinner" style="width:172px;"></td>
            </tr>

            <tr>
                <td>实到人数:</td>
                <td><input id="conference_actualArrivalNum_update" name="conference.actualArrivalNum" class="easyui-numberspinner" style="width:172px;"></td>
            </tr>

            <tr>
                <td>开会日期:</td>
                <td><input id="conference_conferenceDate_update" name="conference.conferenceDate" class="easyui-datebox" style="width:172px;"></td>
            </tr>

            <tr>
                <td>到会者:</td>
                <td>
                    <input id="conference_participatorSet_update" name="participatorIds" class="easyui-textbox" data-options="required:true" style="width:172px;">
                </td>
                <td>支持多选</td>
            </tr>

            <tr>
                <td>备注:</td>
                <td>
                    <textarea id="conference_remark_update" name="conference.remark" placeholder="不超过120个字符" rows="5" maxlength="120" class="textbox" style="resize:none;width:160px;white-space:pre-wrap;padding: 5px"></textarea>
                </td>
            </tr>
        </table>

    </form>
</div>


<script type="text/javascript">

    $(function () {

        //根据会议名称查询
        $("#conference_search_name").textbox({
            icons: [{
                iconCls:'icon-clear',
                handler: function(e){
                    $(e.data.target).textbox('clear');
                }
            }]
        });

        //根据作者名查询
        $("#conference_participator_name").textbox({
            icons: [{
                iconCls:'icon-clear',
                handler: function(e){
                    $(e.data.target).textbox('clear');
                }
            }]
        });


        //查询按钮
        $("#conference_search_btn").linkbutton({
            iconCls : 'icon-search',
            onClick : function(){
                $("#conferenceGrid").datagrid('load',{
                    'conference.name':$("#conference_search_name").textbox('getValue'),
                    //todo:这里有待完成
                    'conference.authorList[0].username':$("#conference_participator_name").textbox('getValue'),
                });
            }
        })

        //新增按钮
        $("#conference_add_btn").linkbutton({
            iconCls : 'icon-add',
            onClick : function(){
                $("#add_conference_dialog").css("display","block");

                $("#add_conference_form").form('clear');

                //会议主持人
                $("#conference_host_add").combobox({
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

                //参会者
                $("#conference_participatorSet_add").combobox({
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

                $("#add_conference_dialog").dialog({
                    title:'新增会议项',
                    modal:true,
                    buttons: [{
                        text: '保存',
                        iconCls: 'icon-ok',
                        handler: function () {
                            $("#add_conference_form").form('submit',{
                                url:'<%=path%>/json/conferenceAction!save',
                                success:function(data){
                                    try{
                                        var res = eval('(' + data + ')');
                                        if(res.result == 'success') {
                                            $.messager.show({
                                                title: '新增会议',
                                                msg: '新增成功!',
                                                timeout: 2000,
                                            });
                                            $("#conferenceGrid").datagrid('reload');
                                            $("#add_conference_dialog").dialog('close');
                                        }
                                    }catch(err){
                                        $.messager.alert('新增会议',data, 'error');
                                    }
                                }
                            })
                        }
                    }, {
                        text: '取消',
                        iconCls: 'icon-cancel',
                        handler: function () {
                            $('#add_conference_dialog').dialog('close');
                        }
                    }],
                });

            }
        })

        //更新按钮
        $("#conference_update_btn").linkbutton({
            iconCls : 'icon-edit',
            onClick : function(){

                var row = $("#conferenceGrid").datagrid('getSelected');
                if (row == null) {
                    $.messager.alert("修改会议",'请先选中需要修改的项。','info');
                    return false;
                }

                //给id赋值便于传递到后台
                $("#conference_id_update").val(row.id);

                $("#update_conference_dialog").css("display","block");

                $("#update_conference_dialog").dialog({
                    title:'修改会议信息',
                    modal:true,
                    buttons: [{
                        text: '保存',
                        iconCls: 'icon-ok',
                        handler: function () {
                            $("#update_conference_form").form('submit',{
                                url:'<%=path%>/json/conferenceAction!update',
                                success:function(data){
                                    $("#update_conference_dialog").dialog('close');

                                    try{
                                        var res = eval('(' + data + ')');
                                        //如果更新成功，做三件事：1.刷新链表，2.提示新增操作成功,3.关闭新增窗口
                                        if (res.result == 'success') {
                                            $.messager.show({
                                                title : '修改会议',
                                                msg : '修改成功!',
                                                timeout : 2000,
                                            });
                                            $("#conferenceGrid").datagrid('reload');
                                            $("#update_conference_dialog").dialog('close');
                                        }
                                    }catch (err){
                                        $.messager.alert('修改会议',data, 'error');
                                    }


                                }
                            })
                        }
                    }, {
                        text: '取消',
                        iconCls: 'icon-cancel',
                        handler: function () {
                            $('#update_conference_dialog').dialog('close');
                        }
                    }],
                });

                //会议主持人
                $("#conference_host_update").combobox({
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

                //参会者
                $("#conference_participatorSet_update").combobox({
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

                //给各字段赋值
                $("#conference_name_update").textbox('setValue',row.name);
                $("#conference_code_update").textbox('setValue',row.code);
                $("#conference_content_update").val(row.content);
                $("#conference_address_update").textbox('setValue',row.address);
                $("#conference_shouldArrivalNum_update").numberspinner('setValue',row.shouldArrivalNum);
                $("#conference_actualArrivalNum_update").numberspinner('setValue',row.actualArrivalNum);

                //到会者
                var authorList = row.participatorSet;
                var authorIds = "";
                for(var i = 0; i < authorList.length; i++){
                    if (authorIds == ""){
                        authorIds += authorList[i].id;
                    }else {
                        authorIds += "," + authorList[i].id;
                    }
                }
                $("#conference_participatorSet_update").combobox('setValues', authorIds.split(","));

                $("#conference_host_update").combobox('setValue',row.host.id);

//                $("#conference_conferenceDate_update").datebox('setValue', row.conferenceDate);
                $("#conference_conferenceDate_update").datebox('setValue',row.conferenceDate);
                $("#conference_remark_update").val(row.remark);
            }
        })

        //删除按钮
        $("#conference_remove_btn").linkbutton({
            iconCls : 'icon-remove',
            onClick : function(){
                var row = $("#conferenceGrid").datagrid('getSelected');
                if (row == null) {
                    $.messager.alert("删除会议",'请先选中需要删除的项。','info');
                    return false;
                }
                $.messager.confirm('删除会议',"确定删除此条记录吗?",function(flag){
                    if(flag){
                        var id = row.id;
                        $.ajax({
                            url:'<%=path%>/json/conferenceAction!delete',
                            type:'post',
                            dataType:'json',
                            data:{
                                'conference.id':row.id
                            },
                            success:function(data){
                                if(data.result == 'success'){
                                    $.messager.show({
                                        title : '删除会议',
                                        msg : '删除成功!',
                                        timeout : 2000,
                                    });
                                    $("#conferenceGrid").datagrid('reload');
                                }else{
                                    $.messager.alert('删除会议','删除失败。');
                                }
                            }
                        });
                    }
                });

            }
        })

        //主体表格
        $("#conferenceGrid").datagrid({
            title:'会议管理',
            pagination:true,
            singleSelect:true,
            rownumbers:true,
            fit:true,
            toolbar:'#conference_search',
            url:'<%=path%>/json/conferenceAction!list',
            columns: [[
                {field: 'code', title: '会议编号'},
                {field: 'name', title: '会议名称'},
                {
                    field: 'host', title: '主持人',
                    formatter: function (value, row, index) {
                        if(row.host){
                            return row.host.username;
                        }
                    }
                },
                {field: 'content', title: '会议内容'},
                {field: 'address', title: '开会地址'},
                {field: 'shouldArrivalNum', title: '应到人数'},
                {field: 'actualArrivalNum', title: '实到人数'},
                {
                    field: 'conferenceDate', title: '开会日期',
                    formatter : function (value, row, index) {
                        return getDate(value);
                    }
                },
                {
                    field: 'participatorSet', title: '到会者',
                    formatter: function (value, row, index) {
                        var participatorStr = "";
                        for(var i = 0; i < value.length; i++){
                            if (participatorStr == ""){
                                participatorStr += value[i].username;
                            }else {
                                participatorStr += " , " + value[i].username;
                            }
                        }
                        return participatorStr;
                    }
                },
                {field: 'remark', title: '备注'},
            ]],
            queryParams: {//和查询时发送的请求保持一致
                'conference.name': '',
//                'conference.authorList[0].username' : '',
            }
        });
    });


</script>

</body>

</html>