<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="/WEB-INF/reuse/path.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <title>Insert title here</title>
</head>
<body>
<a href="<%=path%>/example/sshExampleAction!toSave">新增Example</a>
<table border="1px solid" cellspacing="0">
    <thead>
    <tr>
        <td></td>
        <td>name</td>
        <td>url</td>
        <td>操作</td>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="sshExample" items="${sshExampleList }" varStatus="line">
        <tr>
            <td>${line. count}</td>
            <td>${sshExample.name}</td>
            <td>${sshExample.description}</td>
            <td>
                <a href="<%=path %>/example/sshExampleAction!toUpdate?sshExample.id=${sshExample.id}">修改|</a>
                <a href="<%=path %>/example/sshExampleAction!delete?sshExample.id=${sshExample.id}">删除</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

</body>
</html>