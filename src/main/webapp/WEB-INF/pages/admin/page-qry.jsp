<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="${ctx}/css/base.css" />
<link rel="stylesheet" href="${ctx}/css/info-reg.css" />
<title>移动办公自动化系统</title>
</head>

<body>
<div class="title"><h2>图书详情</h2></div>
<div class="main">
	<p class="short-input ue-clear newstyle">
    	<label>展示编号：</label>${homePage.id }
    </p>
    <p class="short-input ue-clear newstyle">
    	<label>展示名称：</label>${homePage.name }
    </p>
    <p class="long-input ue-clear newstyle">
    	<label>图书：</label>
    	<c:forEach items="${homePage.pageBook.book}" var="o">
			${o.bookname}
		</c:forEach>
    </p>
    <p class="long-input ue-clear newstyle">
    	<label>备注：</label>${homePage.remark }
    </p>

</div>
<div class="btn ue-clear">
	<a href="${ctx}/admin/toHomePagePage.action" class="confirm">返回</a>
</div>
</body>
<script type="text/javascript" src="${ctx}/js/jquery.js"></script>
<script type="text/javascript" src="${ctx}/js/common.js"></script>
<script type="text/javascript" src="${ctx}/js/WdatePicker.js"></script>
<script type="text/javascript">
$(".select-title").on("click",function(){
	$(".select-list").toggle();
	return false;
});
$(".select-list").on("click","li",function(){
	var txt = $(this).text();
	$(".select-title").find("span").text(txt);
});

function checkPhone(){
	
}

//注册
function addUser(){
	$("form").submit();
}

//情况所有
function clearAll(){
	alert("清空所有内容");
}

showRemind('input[type=text], textarea','placeholder');
</script>
</html>