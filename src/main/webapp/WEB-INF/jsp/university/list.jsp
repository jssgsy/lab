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
    学校名: <input id="university_search_name" name="university.name" style="width:100px;">
    <a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchUniversity()" style="width:60px">搜索</a><br/>
    <a class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="add_dialog()" style="width:60px">新增</a>
    <a class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="update_dialog()" style="width:60px">修改</a>
    <a class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="del_dialog()" style="width:60px">删除</a>
</div>

<!-- 新增数据字典窗口,这里直接使用样式设置display=none(不初始化为easyui的dialog，当学校点击的时候才生成dialog),减少负荷-->
<div id="addUniversity_dialog" style="display: none;">
    <form id="addUniversity_form" method="post">
        <table style="text-align: right;padding: 5px 5px;">
            <tr>
                <td>学校名称:</td>
                <td><input id="university_name_add" name="university.name" class="easyui-textbox" data-options="required:true" style="width:172px;"></td>
            </tr>
            <tr>
                <td>学校地址:</td>
                <td>
                    <textarea id="university_address_add" name="university.address" data-options="required:true" class="easyui-textbox" style="width:172px;"></textarea>
                </td>
            </tr>

        </table>
        <div style="text-align: center;margin-top: 20px;">
            <a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="adduniversity()">保存</a>
            <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel',onClick:function(){$('#addUniversity_dialog').dialog('close');}">取消</a>
        </div>
    </form>
</div>

<!-- 修改数据字典窗口,这里直接使用样式设置display=none(不初始化为easyui的dialog，当学校点击的时候才生成dialog),减少负荷-->
<div id="updateUniversity_dialog" style="display: none;">
    <form id="updateUniversity_form" method="post">
        <table style="text-align: right;padding: 5px 5px;">
            <tr>
                <!-- 将文本和input标签放在不同的td中，有助于施加样式，如上面设置将文本向右对齐 -->
                <td>学校名称:</td>
                <td>
                    <input id="university_name_update" name="university.name" class="easyui-textbox" data-options="required:true" style="width:172px;">
                    <input type="hidden" id="university_id_update" name="university.id">
                </td>
            </tr>
            <tr>
                <td>学校地址:</td>
                <td><textarea id="university_address_update" name="university.address"  class="easyui-textbox" data-options="required:true" style="width:172px;"></textarea></td>
            </tr>

        </table>
        <!-- 下面是保存和取消操作（取消操作直接写在这里） -->
        <div style="text-align: center;margin-top: 20px;">
            <a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="updateUniversity()">保存</a>
            <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel',onClick:function(){$('#updateUniversity_dialog').dialog('close');}">取消</a>
        </div>
    </form>
</div>


<script type="text/javascript">

    $("#universityGrid").datagrid({
        title:'学校管理',
        pagination:true,
        singleSelect:true,
        rownumbers:true,
        fit:true,
        toolbar:'#university_search',
        url:'<%=path%>/json/universityAction!list',
        columns: [[
            {field: 'name', title: '学校名称'},
            {field: 'address', title: '学校地址'},
        ]],
        queryParams: {//和查询时发送的请求保持一致
            'university.name': '',
        }
    });



    //查询框中的学校名查询
    $("#university_search_name").textbox({
        icons: [{
            iconCls:'icon-clear',
            handler: function(e){
                $(e.data.target).textbox('clear');
            }
        }]
    });



    //查询数据字典
    function searchUniversity(){
        $("#universityGrid").datagrid('load',{
            'university.name':$("#university_search_name").textbox('getValue'),
        });
    }

    //打开新增窗口
    function add_dialog(){
        $("#addUniversity_dialog").css("display","block");

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
            width:400,
            height:300,
            modal:true
        });
    }

    //真正执行保存操作
    function adduniversity(){
        $("#addUniversity_form").form('submit',{
            url:'<%=path%>/json/universityAction!save',
            success:function(data){
                var data = eval('(' + data + ')');
                //如果新增成功，做三件事：1.刷新链表，2.提示新增操作成功,3.关闭新增窗口
                if(data.result == 'success'){
                    $.messager.alert('新增学校','新增成功。');
                    $("#universityGrid").datagrid('reload');
                }else{
                    $.messager.alert('新增学校','新增失败。');
                }
                $("#addUniversity_dialog").dialog('close');
            }
        });
    }


    //打开修改数据字典
    function update_dialog(){

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
            width:400,
            height:300,
            modal:true
        });
        //给各字段赋值
        $("#university_name_update").textbox('setValue',row.name);
        $("#university_address_update").textbox('setValue', row.address);
    }


    //真正执行更新操作
    function updateUniversity(){
        $("#updateUniversity_form").form('submit',{
            url:'<%=path%>/json/universityAction!update',
            success:function(data){
                var data = eval('(' + data + ')');
                //如果更新成功，做三件事：1.刷新链表，2.提示新增操作成功,3.关闭新增窗口
                if (data.result == 'success') {
                    $.messager.alert('修改学校','修改成功。');
                    $("#universityGrid").datagrid('reload');
                } else {
                    $.messager.alert('修改学校','修改失败。');
                }
                $("#updateUniversity_dialog").dialog('close');
            }
        });
    }

    //删除数据字典
    function del_dialog(){
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
                            $.messager.alert('删除学校','删除成功。');
                            $("#universityGrid").datagrid('reload');
                        }else{
                            $.messager.alert('删除学校','删除失败。');
                        }
                    }
                });
            }
        });
    }
</script>

</body>




</html>