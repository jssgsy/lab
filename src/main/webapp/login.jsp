<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="/WEB-INF/reuse/path.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>

<body style="text-align: center;background: url('<%=path%>/frontWeb/image/zjut.jpeg') no-repeat" >
<h1>实验室管理系统</h1>

<%--开发阶段使用用来跳过登录页面，正式阶段需要删去--%>
<%--todo:需要复习页面上使用jsp的方式--%>
<%--<%
    response.sendRedirect(path+"/json/userAction!login");
%>--%>

<div class="easyui-panel" style="width:350px;padding: 10px;position: absolute;margin: 100px 450px;">
    <form id="loginForm" method="post" action=" <%=path%>/json/userAction!login" onsubmit="return checkBeforeLogin()">
        <div style="margin-bottom:20px">
            用户名：<input class="easyui-textbox" name="user.username" style="width:100%" data-options="required:true">
        </div>

        <div style="margin-bottom:20px">
            密码：<input class="easyui-textbox" name="user.password" style="width:100%" data-options="required:true">
        </div>

        <%--todo:这里的css需要控制一下--%>
        <div style="text-align:center;padding:5px 0">
            <input type="submit" value="登录"/>
            <%--<a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#registWindow').window('open');"
               style="width:80px">去注册</a>--%>
            <input type="button" value="注册" onclick="$('#registWindow').window('open');"/>
        </div>
    </form>

</div>

<%--注册时弹出注册窗口--%>
<div id="registWindow" class="easyui-window" title="用户注册"
     data-options="closed:true,modal:true,collapsible:false,minimizable:false,maximizable:false"
     style="width:300px;padding:10px;">
    <form id="registForm" method="post" action="<%=path%>/json/userAction!regist" onsubmit="return checkBeforeRegist()">
        <div style="margin-bottom:20px">
            用户名：<input class="easyui-textbox" name="user.username" style="width:100%" data-options="required:true">
        </div>

        <div style="margin-bottom:20px">
            密码：<input class="easyui-textbox" id="p1" name="user.password" style="width:100%"
                      data-options="required:true">
        </div>

        <div style="margin-bottom:20px">
            重复密码：<input class="easyui-textbox" id="p2" style="width:100%" data-options="required:true">
        </div>

        <div style="margin-bottom:20px">
            邮箱：<input class="easyui-textbox" name="user.email" style="width:100%"
                      data-options="required:true,validType:'email'">
        </div>

        <div style="margin-bottom:20px">
            手机号码：<input class="easyui-textbox" name="user.telephone" style="width:100%" data-options="">
        </div>

        <div style="text-align:center;padding:5px 0">
            <input type="submit"/>
        </div>
    </form>


</div>


<script>
    function checkBeforeLogin() {
        var isValid = $("#loginForm").form('validate');
        if (!isValid) {
            return false;
        }
        return true;
    }

    function checkBeforeRegist() {
        //利用easyui的form表单验证功能
        var isValid = $("#registForm").form('validate');
        if (!isValid) {
            return false;
        }

        var p1 = $("#p1");
        var p2 = $("#p2");
        if (p1.val() != p2.val()) {
            $.messager.alert("注册失败", "两次输入的密码有误，请重新输入！");
            return false;
        }
        return true;
    }

</script>

</body>
</html>