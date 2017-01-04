<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="/WEB-INF/reuse/path.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>function模块</title>
</head>
<body>
<form action="<%=path %>/example/sshExampleAction!update" method="post">
    <input type="hidden" name="sshExample.id" value="${sshExample.id }"/>
    类别名称: <input type="text" name="sshExample.name" value="${sshExample.name }"/><br>
    类别描述: <input type="text" name="sshExample.description" value="${sshExample.description}"/><br>
    <br>
    保存:<input type="submit"/><br>


</form>
</body>
</html>