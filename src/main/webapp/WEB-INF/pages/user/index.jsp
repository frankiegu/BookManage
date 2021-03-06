<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>读书网</title>
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="stylesheet" href="${ctx}/css/bootstrap.css">
    <link rel="stylesheet" href="${ctx}/css/amazeui.min.css">
    <link rel="stylesheet" href="${ctx}/css/petshow.css">
    <link rel="stylesheet" href="${ctx}/css/animate.min.css">
    
    <link rel="stylesheet" type="text/css" href="${ctx}/css/search-form.css">
    <style type="text/css">
    
    	/*placeholder字体颜色*/
		::-webkit-input-placeholder { /* WebKit browsers */
		    color:#ccc;
		    font-size: 14px;
		}
		:-moz-placeholder { /* Mozilla Firefox 4 to 18 */
		    color:#ccc;
		     font-size: 14px;
		}
		::-moz-placeholder { /* Mozilla Firefox 19+ */
		    color:#ccc;opacity:1;
		     font-size: 14px;
		}
		:-ms-input-placeholder { /* Internet Explorer 10+ */
		    color:#ccc !important;
		     font-size: 14px;
		}
    </style>
    
    <script src="${ctx}/js/jquery.min.js"></script>
    <script src="${ctx}/js/amazeui.min.js"></script>
    <script src="${ctx}/js/bootstrap.js"></script>
    <script src="${ctx}/js/amazeui.lazyload.min.js"></script>
	<script type="text/javascript">
		//页面加载时触发
		$(document).ready(function(){
			
		});
		
		
		function dealClickEvent(id){
			$("#id").val(id);
			document.myform.attributes["action"].value = "${ctx}/user/bookInfo.action"; 
			$("form").submit();
		}
		
		function showModal(){
			$("#myModal").modal('show');
		}
		
		function userMsg(){
			$("#userModal").modal('show');
		}
		function pwdMsg(){
			$("#pwdModal").modal('show');
		}
		
		function setLiked(id){
			var userId = "${user.userId}";
			var bookid = id;
			$.post("${ctx}/user/setLiked.action", { userId:userId,bookid:bookid},function(data){
            	//alert(data.errorInfo);
            	//$("#myModal").modal('hide');
				document.myform.attributes["action"].value = "${ctx}/user/indexPage.action"; 
				$("form").submit();
			},"json");
		}
		
		$(function () {
	        $('#saveMark').click(function () {
	        	var id_array=new Array();  
	            $('input[name="hobby"]:checked').each(function(){  
	                id_array.push($(this).val());//向数组中添加元素  
	            });  
	            var hobby=id_array.join(',');//将数组元素连接起来以构建一个字符串  
	            var userId = "${user.userId}";
	            $.post("${ctx}/user/updUserMark.action", { userId:userId,hobby:hobby},function(data){
	            	alert(data.errorInfo);
	            	$("#myModal").modal('hide');
				},"json");

	        });
	        //更新密码
	        $('#savePwd').click(function () {
	        	var pwd = $("#pwd").val();
	        	var password = $("#password").val();
	        	var password1 = $("#password1").val();
	        	if(password != password1){
	        		alert("重置密码和确认密码不一致！");
	        		return;
	        	}
	        	if(password != pwd){
	        		alert("重置密码和原始密码不能相同！");
	        		return;
	        	}
	            var userId = "${user.userId}";
	            $.post("${ctx}/user/updUserPwd.action", { userId:userId,userPwd:pwd,remark:password1},function(data){
	            	alert(data.errorInfo);
	            	$("#pwdModal").modal('hide');
				},"json");
	        });

	    });
		function searchToggle(obj, evt){
            var container = $(obj).closest('.search-wrapper');

            if(!container.hasClass('active')){
                  container.addClass('active');
                  evt.preventDefault();
            }
            else if(container.hasClass('active') && $(obj).closest('.input-holder').length == 0){
                  container.removeClass('active');
                  // clear input
                  container.find('.search-input').val('');
                  // clear and hide result container when we press close
                  container.find('.result-container').fadeOut(100, function(){$(this).empty();});
            }
        }

        function submitFn(obj, evt){
            value = $(obj).find('.search-input').val().trim();

            _html = "Yup yup! Your search text sounds like this: ";
            if(!value.length){
                _html = "Yup yup! Add some text friend :D";
            }
            else{
                _html += "<b>" + value + "</b>";
            }

            $(obj).find('.result-container').html('<span>' + _html + '</span>');
            $(obj).find('.result-container').fadeIn(100);

            evt.preventDefault();
        }
        
        function doQry(){
    		$("#qryForm").action="${ctx}/user/toQryBookPage.action"; 
    		$("#qryForm").submit();
        }
	</script>
</head>
<body>
<header class="am-topbar am-topbar-inverse">
    <div class="amz-container">
        <h1 class="am-topbar-brand">
            <a href="#" class="am-topbar-logo">
                <img src="${ctx}/img/logo.png?1" alt="">
            </a>
        </h1>
        <button class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-success am-show-sm-only"
                data-am-collapse="{target: '#doc-topbar-collapse-5'}">
            <span class="am-sr-only">
                导航切换
            </span>
            <span class="am-icon-bars">
            </span>
        </button>
        <div class="am-collapse am-topbar-collapse" id="doc-topbar-collapse-5">
            <ul class="am-nav am-nav-pills am-topbar-nav">
                <li class="am-active">
                    <a href="${ctx}/user/indexPage.action">首页</a>
                </li>
                <li>
                    <a href="${ctx}/user/qryLoveBook.action?userId=${user.userId}">我的图书</a>
                </li>
                <c:if test="${userName != null}">
                	<li class="am-dropdown" data-am-dropdown="">
	                    <a href="javascript:;"> 欢迎您,${userName }</a>
	                </li>
				</c:if>
				<c:if test="${userName == null}">
				    <li class="am-dropdown" data-am-dropdown="">
	                    <a href="${ctx}/user/login.action"> 登录</a>
	                </li>
					<li class="am-dropdown" data-am-dropdown="">
	                    <a href="${ctx}/user/toRegistPage.action">注册</a>
	                </li>
				</c:if>
                <li>
                    <a href="${ctx}/user/userInfoPage.action">个人中心</a>
                </li>
                <li>
                    <a onclick="pwdMsg()">密码重置</a>
                </li>
                <li>
                    <a href="${ctx}/user/exitSystem.action">注销</a>
                </li>
                <li>
                	<form action="${ctx}/user/toQryBookPage.action" name="qryForm" id="qryForm" method="post">
                		<div class="bdfw_nr_title">
							<input type="text" name="qryName" id="qryName" style="margin-top:7px;margin-left:15px;width:200px;height:36px;color:#AAAAAA;font-size:medium" placeholder="图书名称、作者">
							<a onclick="doQry()"><img alt="" src="${ctx}/img/search.png" style="margin-top:10px"></a>
						</div>
                	</form>
                </li>
            </ul>
        </div>
    </div>
</header>

<div style="display:none">
	<button onclick="showModal()">
		开始演示模态框
	</button>
</div>
<form action="${ctx}/user/saveMark.action" method="post" name="myform1" id="myform1">
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
						&times;
					</button>
					<h4 class="modal-title" id="myModalLabel">
						标记喜欢的图书标签
					</h4>
				</div>
				<div class="modal-body">
					<c:forEach items="${marks}" var="o">
						<span>
							<input type="checkbox" name="hobby" value="${o.id }"> ${o.name } &nbsp;
						</span>
					</c:forEach>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭
					</button>
					<button type="button" class="btn btn-primary" id="saveMark">
						保存
					</button>
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal -->
	</div>
</form>

	<div class="modal fade" id="pwdModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog" style="width:350px">
			<div class="modal-content" style="width:350px">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
						&times;
					</button>
					<h4 class="modal-title" id="myModalLabel">
						密码重置
					</h4>
				</div>
				<form class="form-inline" id="pwdForm" method="POST">
					<div class="form-group">
						<label for="name" style="text-indent: 2em;font-size: 14px;">原始密码：</label>
						<input type="password" class="form-control" id="pwd" placeholder="请输入原始密码">
					</div>
					<br/>
					<div class="form-group">
						<label for="name" style="text-indent: 2em;font-size: 14px;">重置密码：</label>
						<input type="password" class="form-control" id="password" placeholder="请输入重置密码">
					</div>
					<br/>
					<div class="form-group">
						<label for="name" style="text-indent: 2em;font-size: 14px;">确认密码：</label>
						<input type="password" class="form-control" id="password1" placeholder="请输入确认密码">
					</div>
					<br/>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭
						</button>
						<button type="button" class="btn btn-primary" id="savePwd">
							保存
						</button>
					</div>
				</form>
			</div><!-- /.modal-content -->
		</div><!-- /.modal -->
	</div>

<div class="banner_navbg">
    <div class="am-g">
        <div class="banner_nav">
			<span class="am-icon-caret-right">  筛选：</span>
				<a href="###">人气最高</a>
				<a href="###" class="banner_hover">编辑推荐</a>
				<a href="###">最新萌宠</a>
				<a href="###">语言涂鸦</a>
		</div>
    </div>
</div>

<form action="${ctx}/user/bookInfo.action" method="post" name="myform" id="myform">
	<input type="hidden" id="id" name="id"> 
</form>

<div class="am-g am-imglist">
	<c:forEach items="${dataList}" var="o">
		<!-- 分类展示 -->
		<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${o.name}</span>
		<ul data-am-widget="gallery" class="am-gallery am-avg-sm-2 am-avg-md-3 am-avg-lg-6 am-gallery-default">
			<c:forEach items="${o.pageBook.book}" var="pbook">
				<li>
		            <div class="am-gallery-item am_list_block">
		                <a href="###" class="am_img_bg">
		                    <img class="am_img animated" src="${ctx}/${pbook.imageUrl}"  onclick="dealClickEvent('${pbook.bookid}')"/>
		                </a>
		
		                <div class="am_listimg_info">
		                	<span class="am-icon-heart" onclick="setLiked('${pbook.bookid}')"> ${pbook.number}</span>
		                	<span class="am-icon-eye"> ${pbook.times}</span>
		                </div>
		
		            </div>
		            <a class="am_imglist_user"><span class="am_imglist_user_ico"><img src="${ctx}/img/logo.png" alt=""></span><span
		                    class="am_imglist_user_font">${pbook.bookname}</span></a>
		        </li>
		        </a>
			</c:forEach>
	    </ul>
	</c:forEach>
	
	<!-- 图书推荐，猜你喜欢模块 -->
	<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;猜你喜欢</span>
    <ul data-am-widget="gallery" class="am-gallery am-avg-sm-2 am-avg-md-3 am-avg-lg-6 am-gallery-default">
       	<c:forEach items="${books}" var="bk">
       		<li>
	            <div class="am-gallery-item am_list_block">
	                <a href="###" class="am_img_bg">
	                    <img class="am_img animated" src="${ctx}/${bk.imageUrl}"  onclick="dealClickEvent('${bk.bookid}')"/>
	                </a>
	
	                <div class="am_listimg_info"><span class="am-icon-heart" onclick="setLiked('${bk.bookid}')"> ${bk.number}</span><span
	                        class="am-icon-eye"> ${bk.times}</span><span class="am_imglist_time">15分钟前</span></div>
	
	            </div>
	            <a class="am_imglist_user">
	            	<span class="am_imglist_user_ico">
	            		<img src="${ctx}/img/logo.png" width="200" height="230">
	            	</span>
	            	<span class="am_imglist_user_font">${bk.bookname}</span>
	            </a>
	        </li>
       	</c:forEach>
        
        
    </ul>
</div>
<footer class="am_footer">
    <div class="am_footer_con">
        <div class="am_footer_link">
            <span>关于图书网</span>
            <ul>
                <li><a href="###">关于我们</a></li>
                <li><a href="###">发展历程</a></li>
                <li><a href="###">友情链接</a></li>
            </ul>
        </div>


        <div class="am_footer_don">
            <span>读书网</span>
            <dl>
                <dt><img src="${ctx}/img/logo.png?1" alt=""></dt>
                <dd>一起Show我们的爱宠吧！宠物秀是图片配文字、涂鸦、COSPLAY的移动手机社区，这里有猫狗鱼龟兔子仓鼠龙猫等各种萌图。
                    <a href="###" class="footdon_pg ">
                        <div class="foot_d_pg am-icon-apple "> App store</div>
                    </a><a href="###" class="footdon_az animated">
                        <div class="foot_d_az am-icon-android "> Android</div>
                    </a></dd>

            </dl>
        </div>

        <div class="am_footer_erweima">
            <div class="am_footer_weixin"><img src="${ctx}/img/wx.jpg" alt="">

                <div class="am_footer_d_gzwx am-icon-weixin"> 关注微信</div>
            </div>
            <div class="am_footer_ddon"><img src="${ctx}/img/wx.jpg" alt="">

                <div class="am_footer_d_dxz am-icon-cloud-download"> 扫码下载</div>
            </div>

        </div>

    </div>
</footer>
</body>
</html>