<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
String s_ID = (String) session.getAttribute("s_ID");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
if(s_ID == null) {%>
<script>
alert("먼저 로그인을 해주세요.")
location.href="/board/login_page";
</script> 

</head>
<body>
<%}else { %>
<%@include file="../includes/header-logout.jsp" %>
<%} %>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Register</h1>
	</div>
	
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Board Register</div>
			<div class="panel-body">
				<form role="form" action="/board/register" method="post">
					<div class="form-group">
						<label>제목</label><input class="form-control" name="title" required>
					</div>
					<div class="form-gorup">
						<label>내용</label>
						<textarea class="form-control" rows="10" name="content"></textarea>
					</div>
					<div class="form-gorup">
						<label>작성자</label>
						<input class="form-control" name="user_id" value="<%=s_ID %>" readonly>
					</div>
					<div class="margin_top5px" style="margin-top:15px"></div>
					<button type="submit" class="btn btn-default">Submit Button</button>
					<button type="reset" class="btn btn-default">Reset Button</button>
					
				</form>
			</div>
		</div>
	</div>
</div>
</div>
<%@include file="../includes/footer.jsp" %>
</body>
</html>