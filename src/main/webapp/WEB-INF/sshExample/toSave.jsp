<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="/WEB-INF/reuse/path.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>insert title here</title>
</head>
<body>

<form action="<%=path %>/example/sshExampleAction!save" method="post">
    Example name: <input type="text" name="sshExample.name"/><br>
    Example description: <input type="text" name="sshExample.description"/><br>
    <br>
    保存:<input type="submit"/><br>
</form>

</body>
</html>