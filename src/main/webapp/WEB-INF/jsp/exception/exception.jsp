<%@ taglib prefix="s" uri="/struts-tags" %>
<%--引入spring的异常包--%>
<%@ page language="java" import="org.springframework.dao.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="/WEB-INF/reuse/path.jsp" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>


<%
    Object ex = request.getAttribute("exception");
    if(ex instanceof DataIntegrityViolationException){
        request.setAttribute("msg", "您的操作违反了数据之间的约束，请注意查看您操作的数据，或者稍后再试。");
    }else {
        //todo:仅供开发模式使用，便于跟踪异常
        request.setAttribute("msg", ex);
        //request.setAttribute("msg", "未知错误，请联系此邮箱:fcsnwu@163.com，或者稍后再试。");
    }
%>

<%--todo:后期捕获异常，但只给出最宽泛的提示信息--%>

${msg}

</body>
</html>