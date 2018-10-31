<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
String s_ID = (String) session.getAttribute("s_ID");
String s_img = (String) session.getAttribute("s_img");
int imgCnt = 0;
int Slider = 0;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

</style>
</head>
<body>
<%
if(s_ID == null) {%>
<script>
alert("먼저 로그인을 해주세요.")
location.href="/board/login_page";
</script> 
<%}else { %>
<%@include file="../includes/header-logout.jsp" %>
<%} %>
<div style="margin-top: 100px;"></div>

<div class="container-fluid row">
	<div class="col-lg-2" ></div>
	<div class="col-lg-4" id="backgroundinfo">
		<h3 class="page-header" style="margin-top: 50px; border-bottom:1px solid #eee;"></h3>
			<div class="panel panel-default" ">
             	<div class="panel-heading" style="border: none; color: black; background-color: white;" >
             		
             		<div style="width: 200px; margin:0 auto">
             		<img src="<%=s_img %>" style="width: 200px; border-radius:50%; margin:0 auto;">
             		<br><h2 class="text-center"><%=s_ID %></h2>
             		<h5 class="text-center">내가 팔로워하는 사람</h5>
             		</div>
             		<div class="fc" style="width: 150px; margin: 0 auto;">
             		<form action="/personal/followSearch"> <!-- 팔로워검색 -->
             			<input type="text" class="form-group text-center" style=" width: 130; height: 30px; border:none; border-radius: 10px; background-color: whitesmoke; margin: 0 auto;">
             		</form>
             		
             		</div>
            	</div>
            	<div class="panel-body" style="background-color: whitesmoke; height: 400px; overflow: auto">
           			 <c:forEach items="${list}" var="list">
             		<div class="followList" >
             			<form action="/personal/follow.do" method="post" class="followForm">
             			<img src="<c:out value="${list.follow_img}" />"  style=" width:30px; border-radius: 50%; border: 1px solid purple">
             			<a href="/personal/mypage?user_id=<c:out value="${list.following }" />"  style="cursor: pointer;"><input type="text" class="followName" readonly value="<c:out value="${list.following }" />"style="border:none; background-color:transparent; cursor: pointer; "></a>
             			<input type="submit" class="btn btn-default btn-xs pull-right" value="언팔로우" style="width: 80px;" >
             			<input type="hidden" class="my_id" value="<%=s_ID %>">
             			</form>
             			<div class="divider" style="margin-bottom:20px;"></div>
             		</div>
	             	</c:forEach>
             	</div>
            </div>
	</div>
	<div class="col-lg-4" id="backgroundinfo">
		<h3 class="page-header" style="margin-top: 50px; border-bottom:1px solid #eee;"></h3>
			<div class="panel panel-default" ">
             	<div class="panel-heading" style="border: none; color: black; background-color: white;" >
             		
             		<div style="width: 200px; margin:0 auto">
             		<img src="<%=s_img %>" style="width: 200px; border-radius:50%; margin:0 auto;">
             		<br><h2 class="text-center"><%=s_ID %></h2>
             		<h5 class="text-center">나를 팔로워하는 사람</h5>
             		</div>
             		<div class="fc" style="width: 150px; margin: 0 auto;">
             		<form action="/personal/followSearch"> <!-- 팔로워검색 -->
             			<input type="text" class="form-group text-center" style=" width: 130; height: 30px; border:none; border-radius: 10px; margin: 0 auto;">
             		</form>
             		
             		</div>
            	</div>
            	<div class="panel-body" style="background-color: whitesmoke; height: 400px; overflow: auto">
           			 <c:forEach items="${listM}" var="listM">
             		<div class="followList" >
             			<form action="/personal/follow.do" method="post" class="myFollowForm">
             			<img src="<c:out value="${listM.follow_img}" />"  style=" width:30px; border-radius: 50%; border: 1px solid purple">
             			<a href="/personal/mypage?user_id=<c:out value="${listM.user_id }" />"  style="cursor: pointer;"><input type="text" class="followName" readonly value="<c:out value="${listM.user_id }" />"style="cursor: pointer; border:none; background-color:transparent; "></a>
             			<input type="submit" class="btn btn-default btn-xs pull-right" value="" style="width: 80px;" >
             			<input type="hidden" class="my_id" value="<%=s_ID %>">
             			</form>
             			<div class="divider" style="margin-bottom:20px;"></div>
             		</div>
	             	</c:forEach>
             	</div>
            </div>
	</div>
	<div class="col-lg-2" ></div>
</div>
                
<script>
	$(".followForm").on("submit", function(e) {
		console.log("팔로우폼작동인식되었다.")
		event.preventDefault();
		var f_id = $(this).find('input.followName').val();
		var my_id = $(this).find('input.my_id').val();
		var selectBtn = $(this).find('input.btn').val();
		var noval = $(this).find('input.btn');
		console.log(f_id);
		console.log(my_id);
		console.log(selectBtn);
		
		 if(f_id != null) {
			
			$.ajax({
				type: 'POST',
				url: '/personal/follow.do',
				data: {user_id : my_id, following :  f_id},
				success: function(result) {
					
					console.log("follbtn result"+ result)
					
					if(result == 1) {
						//언팔->팔로우
						noval.prop('value', '언팔로우');
						noval.attr("class", "btn btn-primary btn-xs pull-right");
					}else if (result == 2) {
						//팔로우->언팔
						noval.prop('value', '팔로우');     							
						noval.attr("class", "btn btn-default btn-xs pull-right");

					}
				}
			});
		} 
		
	});
	
	$(".myFollowForm").on("submit", function(e) {
		
		console.log("팔로우폼작동인식되었다.")
		event.preventDefault();
		
		var f_id = $(this).find('input.followName').val();
		var my_id = $(this).find('input.my_id').val();
		var selectBtn = $(this).find('input.btn').val();
		var noval = $(this).find('input.btn');
		console.log(f_id);
		console.log(my_id);
		console.log(selectBtn);
		
		$.ajax({
			type: 'POST',
			url: '/personal/myfollow.do',
			data: {following : f_id, user_id : my_id},
			success: function(result) {
				console.log("my follbtn result"+ result)
				
				if(result == 1) {
					//언팔->팔로우
					noval.prop('value', '언팔로우');
					noval.attr("class", "btn btn-primary btn-xs pull-right");
				}else if (result == 2) {
					//팔로우->언팔
					noval.prop('value', '팔로우');     							
					noval.attr("class", "btn btn-default btn-xs pull-right");
				}
			}
		});
	});
	
</script>                


<script type="text/javascript">
	$(document).ready(function() {
		
		var f_id = $(".myFollowForm").find('input.followName').val();
		var my_id = $(".myFollowForm").find('input.my_id').val();
		var selectBtn = $(".myFollowForm").find('input.btn').val();
		var noval = $(".myFollowForm").find('input.btn');
		console.log("ready Function myfollowForm:"+ f_id);
		console.log("ready Function myfollowForm:"+my_id);
		console.log("ready Function myfollowForm:"+selectBtn);
		
		$.ajax({
			type: 'POST',
			url: '/personal/followChk.do',
			data: {following : f_id, user_id : my_id},
			success: function(result) {
				console.log("following chk.do"+ result)
				
				if(result == 1) {
					//팔로우->언팔
					noval.prop('value', '언팔로우');
					noval.attr("class", "btn btn-primary btn-xs pull-right");
				}else if (result == 0) {
					//팔로우->언팔
					noval.prop('value', '팔로우');     							
					noval.attr("class", "btn btn-default btn-xs pull-right");
				}
			}
		});
		
		
		
		
		var success = '<c:out value="${success}" />';
			checkModal(success);
			
			history.replaceState({},null,null);
		
		function checkModal(success) {
			
			if(success === '' || history.state) {
				return;
			}
			if(success != '') {
				$("#suc-modal-body").html(success)
			}
				$("#successModal").modal("show");
			}
	});
</script>

<%@include file="../includes/footer.jsp" %>
</body>
</html>