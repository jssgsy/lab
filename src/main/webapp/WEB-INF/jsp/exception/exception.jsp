<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="/WEB-INF/reuse/path.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>
<h3>
    <a href="<%=path%>/login.jsp">回到首页</a>
</h3>

<h3>Error Message</h3>
<s:actionerror/>
<p>
    <s:property value="%{exception.message}"/>
</p>
<hr/>

<h3>Technical Details</h3>
<p>
    <s:property value="%{exceptionStack}"/>
</p>


</body>



</html>