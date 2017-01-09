<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="/WEB-INF/reuse/path.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>

<div class="easyui-layout" style="width:100%;height:100%">
    <div data-options="region:'west',title:'数据字典管理'" style="width:200px;">
        <ul id="dictionary_tree"></ul>
    </div>
    <div data-options="region:'center',title:'详情',tools:'#dictionary_tool'" style="padding:5px 5px;">
        <div style="width:400px;height:300px;">
            <form id="updateDictionary_form" method="post">
                <table style="text-align: right;padding: 5px 5px;">
                    <tr>
                        <!-- 将文本和input标签放在不同的td中，有助于施加样式，如上面设置将文本向右对齐 -->
                        <td>名称:</td>
                        <td>
                            <input id="dic_name_update" name="dictionary.name" class="easyui-textbox" data-options="required:true" style="width:172px;">
                            <input type="hidden" id="id_update" name="dictionary.id">
                        </td>
                    </tr>
                    <tr>
                        <td>简介:</td>
                        <td><input id="description_update" name="dictionary.description" class="easyui-textbox" style="width:172px;"></td>
                    </tr>

                    <tr>
                        <td>所属数据类型:</td>
                        <td><input id="dic_parent_update" name="dictionary.parent.id" style="width:172px;"></td>
                    </tr>
                </table>

                <div style="text-align: center;margin-top: 20px;">
                    <a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="updateDictionary()">修改</a>
                    <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="delDictionary_dialog()">删除</a>
                </div>
            </form>
        </div>
    </div>
    <div id="dictionary_tool">
        <a href="javascript:void(0)" class="icon-add" onclick="addDictionary_dialog()"></a>
    </div>

    <!-- 新增字典项窗口-->
    <div id="addDictionary_dialog" style="display: none;">
        <form id="addDictionary_form" method="post">
            <table style="text-align: right;padding: 5px 5px;">
                <tr>
                    <!-- 将文本和input标签放在不同的td中，有助于施加样式，如上面设置将文本向右对齐 -->
                    <td>名称:</td>
                    <td><input id="name_add" name="dictionary.name" class="easyui-textbox" data-options="required:true" style="width:172px;"></td>
                </tr>
                <tr>
                    <td>简介:</td>
                    <td><input id="description_add" name="dictionary.description" class="easyui-textbox" style="width:172px;"></td>
                </tr>
                <tr>
                    <td>所属数据类型:</td>
                    <td><input id="parent_add" name="dictionary.parent.id" style="width:172px;"></td>
                </tr>
            </table>
            <!-- 下面是保存和取消操作（取消操作直接写在这里） -->
            <div style="text-align: center;margin-top: 20px;">
                <a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="addDictionary()">保存</a>
                <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel',onClick:function(){$('#addDictionary_dialog').dialog('close');}">取消</a>
            </div>
        </form>
    </div>
</div>
<script type="text/javascript">
    $(function(){

        $("#dictionary_tree").tree({
            url:'<%=path%>/json/dictionaryAction!getDictionaryTree',
            onClick:function(node){
                $("#dic_name_update").textbox('setValue',node.text);
                $("#id_update").val(node.id);//便于传递到后台作为更新的id
                $("#description_update").textbox('setValue',node.attributes.description);
                $("#dic_parent_update").combobox('setValue',node.attributes.parent.id);
            }
        });

        //所属菜单
        $("#dic_parent_update").combobox({
            url:'<%=path%>/json/dictionaryAction!getTopDictionarys',
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
    });

    //新增数据字典(打开新增窗口)
    function addDictionary_dialog(){
        $("#addDictionary_dialog").css("display","block");

        //所属菜单
        $("#parent_add").combobox({
            url:'<%=path%>/json/dictionaryAction!getTopDictionarys',
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

        $("#addDictionary_dialog").dialog({
            title:'新增数据字典',
            width:350,
            height:250,
            modal:true
        });
    }

    //真正新增数据字典的场所
    function addDictionary(){
        $("#addDictionary_form").form('submit',{
            url:'<%=path%>/json/dictionaryAction!save',
            success:function(data){
                var data = eval('(' + data + ')');
                if (data.result == 'success') {
                    $.messager.alert('新增数据字典','新增成功。');
                    $("#dictionary_tree").tree('reload');
                    $("#addDictionary_dialog").dialog('close');
                } else {
                    $.messager.alert('新增数据字典','新增失败。');
                    $("#addDictionary_dialog").dialog('close');
                }
            }
        });
    }

    //修改数据字典
    function updateDictionary(){
        var node = $("#dictionary_tree").tree('getSelected');
        if (node == null) {
            $.messager.alert("修改数据字典",'请先从树中选中需要更新的数据字典。','info');
            return false;
        }

        $("#updateDictionary_form").form('submit',{
            url:'<%=path%>/json/dictionaryAction!update',
            success:function(data){
                var data = eval('(' + data + ')');
                if (data.result == 'success') {
                    $.messager.alert('修改数据字典','修改成功。');
                    $("#dictionary_tree").tree('reload');
                } else {
                    $.messager.alert('修改数据字典','修改失败。');
                }
            }
        });
    }

    //删除数据字典
    function delDictionary_dialog(){
        var node = $("#dictionary_tree").tree('getSelected');
        if (node == null) {
            $.messager.alert("删除数据字典",'请先从树中选中需要删除的数据字典。','info');
            return false;
        }
        if(!$("#dictionary_tree").tree('isLeaf',node.target)){
            $.messager.alert('删除数据字典','非叶子节点不能删除。','warning');
            return false;
        }
        $.messager.confirm('删除数据字典',"确定删除此条记录吗?",function(flag){
            if(flag){
                var id = node.id;
                $.ajax({
                    url:'<%=path%>/json/dictionaryAction!deleteById',
                    type:'post',
                    dataType:'json',
                    data:{id:node.id},
                    success:function(data){
                        if(data.result == 'success'){
                            $.messager.alert('删除数据字典','删除成功。');
                            $("#dictionary_tree").tree('reload');
                        }else{
                            $.messager.alert('删除数据字典','删除失败。');
                        }
                    }
                });
            }
        });
    }
</script>


</body>


</html>