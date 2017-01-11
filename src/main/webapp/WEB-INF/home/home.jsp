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
<body class="easyui-layout">

<div data-options="region:'north', title:'页眉', split:true" style="height: 100px;width: 100%;"></div>
<div data-options="region:'west', title:'导航' " style="width: 20%;">
    <ul id="menu_nav_tree"></ul>
</div>
<div  data-options="region:'center', showHeader:false " style="width: 80%;">
    <div id="globle_tabs" class="easyui-tabs" data-options="fit:true"><!-- 在最外层设置fit属性 -->
        <div data-options="title:'欢迎页',border:false,closable:true" style="padding:10px;">
            welcome。
        </div>
    </div>
</div>
<div data-options="region:'south', title:'页脚' " style="height: 10%;text-align: center;padding-top: 10px">
    浙江工业大学屏峰校区计算机学院
</div>


<script type="text/javascript">
    $(function(){
        $("#menu_nav_tree").tree({
            //-1：初次加载树
            url:'<%=path%>/json/menuAction!getMenuTree',
            onClick:function(node){
                var url = '<%=path%>/json' + node.attributes.url;
                if(node.attributes.url){//说明不是根节点
                    if(!$("#globle_tabs").tabs('exists',node.text)){
                        $("#globle_tabs").tabs('add',{
                            title:node.text,
                            href:url,
                            closable:true
                        });
                    }else{//此tab已存在则选中此tab
                        $("#globle_tabs").tabs('select',node.text);
                    }
                }
            }
        });
    });












</script>













</body>
</html>