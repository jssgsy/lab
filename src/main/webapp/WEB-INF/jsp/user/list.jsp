<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="/WEB-INF/reuse/path.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>

<table id="userGrid"></table>



<script type="text/javascript">
    $(function () {
        $("#userGrid").datagrid({
            url: '<%=path%>/json/userAction!list',
            columns: [[
                {field: 'username', title: '用户名'},
                {field: 'password', title: '密码'},
                {field: 'telephone', title: '电话'},
                {field: 'email', title: '邮箱'}
            ]],
            pagination : true,
            rownumbers : true,
        });
    })

</script>

</body>




</html>