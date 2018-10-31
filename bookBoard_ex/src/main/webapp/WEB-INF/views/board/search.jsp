<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>SB Admin 2 - Bootstrap Admin Theme</title>
    <!-- Bootstrap Core CSS -->
    <link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- MetisMenu CSS -->
    <link href="/resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">
    <!-- DataTables CSS -->
    <link href="/resources/vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">
    <!-- DataTables Responsive CSS -->
    <link href="/resources/vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">
    <!-- Custom Fonts -->
    <link href="/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<style>
.back-to-top {
	cursor: pointer;
    position: fixed;
    bottom: 20px;
    right: 20px;
}


</style>
</head>
<body>
<%if(session.getAttribute("s_ID") == null || session.getAttribute("s_ID") == ""){%>
<%@include file="../includes/header.jsp" %>
<%
}else {
%>
<%@include file="../includes/header-logout.jsp"%>
<%} %>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header" style="margin-top:150px"><c:out value="${keyword}" />로 검색한 결과</h1>
	</div>
</div>
            <div class="row">
            <c:forEach items="${list}" var="board">
                <div class="col-md-4">
                	<div class="panel panel-default">
                		<div class="panel-heading">
                		<div style="height: 25px; overflow:hidden"><a href=/board/contentView?bno=<c:out value="${board.bno}"/> style="font-size:1.2em; font-weight:bold; color: black;"><c:out value="${board.title }" /></a></div>
                		<a href="#"><img src="<c:out value="${board.user_img }" />" style="width:25px; border-radius: 50%;"></a>
                		<a href="#" style="padding:5px; font-size:14px; color: #A4A4A4;"><c:out value="${board.user_id }" /></a>
                		</div>
                		<a href=/board/contentView?bno=<c:out value="${board.bno}"/>> 
                		<div class="panel-body" style="overflow:hidden; margin:0 auto; padding:0;">
                		<c:choose>
                		<c:when test="${board.main_img eq 'not' }">
                		<img src="/user/default-image.png" style="width: 300px; height:300px"  >
           
                		</c:when>
                		<c:otherwise>
                		<div class="imagBox" style="width:300px; height: 300px;">
                		<img src="/upload/display?fileName=<c:out value="${board.main_img}" />"  >
                		</div>
                		
                		</c:otherwise>
                		</c:choose>
                		</div></a>
                	</div>	
                </div>
            </c:forEach>
        <button type="button" id="regBtn" class="btn btn-info affix back-to-top btn-circle" ><i class="fa fa-plus"></i></button>
            </div>
            
<!-- 모달영역 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">Modal title</h4>
			</div>
			<div class="modal-body">처리가 완료되었습니다.</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary">Save changes</button>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	$(document).ready(function() {
		
		var result = '<c:out value="${result}" />';
		
		checkModal(result);
		
		history.replaceState({},null,null);
		
		function checkModal(result) {
			
			if(result === '' || history.state) {
				return;
			}
			if(result != '') {
				
				$(".modal-body").html(result)
			}
				$("#myModal").modal("show");
				
			}
		
		
		$("#regBtn").on("click", function() {
			self.location = "/upload/register";
		});
		
	});
</script>
            
<%@include file="../includes/footer.jsp" %>

</body>

</html>
