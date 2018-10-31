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
</head>
<body>
<%@include file="../includes/header.jsp" %>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Tables</h1>
	</div>
</div>
<img src="/user/default-user.png">
            <c:forEach items="${list}" var="board">
            <div class="row">
                <div class="col-md-4">
                	<div class="panel panel-default">
                		<div class="panel-heading"><c:out value="${board.user_id }"></c:out></div>
                		<div class="panel-body">
                			<table class="table table-striped table-bordered table-hover" style="float:left;">
                				<thead>
                					<tr>
                						<th>아이디</th>
                						<th>제목</th>
                						<th>내용</th>
                						<th>작성일</th>
                						<th>작성일</th>
                						<th>작성일</th>
                						<th>작성일</th>
                						<th>작성일</th>
                						<th>작성일</th>
                					</tr>
                				</thead>
                				<tr>
                					<td><c:out value="${board.user_id }"></c:out></td>
                					<td><c:out value="${board.user_pw }" /></td>
                					<td><c:out value="${board.user_name }" /></td>
                					<td><c:out value="${board.user_email }" /></td>
                					<td><c:out value="${board.user_point }" /></td>
                					<td><img src="/<c:out value="${board.user_img }"/>"></td>
                					<td><c:out value="${board.user_join_date }" /></td>
                					<td><c:out value="${board.user_login_date }" /></td>
                					<td><c:out value="${board.user_signature }" /></td>	
                				</tr>
                			</table>
                		</div>
                	</div>
                </div>
            </div>
            </c:forEach>
<%@include file="../includes/footer.jsp" %>

</body>

</html>
