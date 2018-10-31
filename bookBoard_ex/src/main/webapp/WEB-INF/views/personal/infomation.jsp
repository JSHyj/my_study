<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
String s_ID = (String) session.getAttribute("s_ID");
String s_img = (String) session.getAttribute("s_img");
String user_id = request.getParameter("user_id");
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
if(s_ID == user_id) {%>
<script>
alert("잘못된 접속입니다.")
location.href="/board/list";
</script> 
<%}else { %>
<%@include file="../includes/header-logout.jsp" %>
<%} %>
<div style="margin-top: 100px;"></div>

<div class="container-fluid row">
	<div class="col-lg-3" ></div>
	<div class="col-lg-6" id="backgroundinfo">
		<h3 class="page-header" style="margin-top: 50px; border-bottom:1px solid #eee;"></h3>
			<div class="panel panel-default" ">
             	<div class="panel-heading" style="border: none; color: black; text-align: center;background-color: white;" >
            		<h1>회원정보수정하기</h1>
            	</div>
            	<div class="panel-body" style="background-color: whitesmoke; margin:0 auto; height: 400px; overflow: auto">
<form>
<table class="table table-bordered">

    <tr>
      <th scope="col">이름</th>
      <th scope="col"><input type="text" name="name" id="name"></th>
    </tr>
    <tr>
      <th scope="col">비밀번호</th>
      <td><input type="password" name="password" id="password"></td>
    </tr>
    <tr>
      <th scope="col">비밀번호 확인</th>
      <td><input type="password" name="password" id="password"></td>
    </tr>
    <tr>
      <th scope="col">이메일</th>
      <td><input type="text" name="email" id="email"></td>
    </tr>
    <tr>
    	<th scope="col">프로필사진</th>
     	<td><input type="file" name="user_img" id="user_img"></td>
    <tr>
    	<td colspan="2" style="text-align: center; "><input type="submit" class="btn btn-primary pull-right" value="제출"></td>
</table>
</form>
             	</div>
            </div>
	</div>
	<div class="col-lg-3" ></div>
</div>
                
<script>
	$("form").on("submit", function(e) {
		console.log("작동인식되었다.")
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
						noval.attr("class", "btn btn-warning btn-xs pull-right");
					}else if (result == 2) {
						//팔로우->언팔
						noval.prop('value', '팔로우');     							
						noval.attr("class", "btn btn-default btn-xs pull-right");

					}
				}
			});
		} 
		
	});
</script>                




<%-- <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">글 삭제하기</h4>
			</div>
			<div class="modal-body">
			<h3>정말로 삭제하시겠습니까?</h3>
			<a href="/board/delete?bno=<c:out value="${board.bno}"/>"><button data-oper='delete' class="btn btn-danger">삭제</button></a>
			<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
<!-- 리다이렉트 메세지 -->
<div class="modal fade" id="successModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">Modal title</h4>
			</div>
			<div class="modal-body" id="suc-modal-body">처리가 완료되었습니다.</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div> --%>

<script type="text/javascript">
	$(document).ready(function() {
		
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