<%
	String path = request.getScheme() + "://" + request.getLocalName() + ":" 
					+ request.getLocalPort() + application.getContextPath();
%>

<%--导入easyui相关文件--%>
<link rel="stylesheet" type="text/css" href="<%=path%>/easyui/themes/default/easyui.css">
<!--使用easyUI的图标-->
<link rel="stylesheet" type="text/css" href="<%=path%>/easyui/themes/icon.css">
<script type="text/javascript" src="<%=path%>/easyui/jquery.min.js"></script>
<script type="text/javascript" src="<%=path%>/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=path%>/easyui/easyui-lang-zh_CN.js"></script>

<%--自定义的css文件--%>
<link rel="stylesheet" type="text/css" href="<%=path%>/frontWeb/css/main.css">

<%--自定义的js文件--%>
<script type="text/javascript" src="<%=path%>/frontWeb/js/main.js"></script>

