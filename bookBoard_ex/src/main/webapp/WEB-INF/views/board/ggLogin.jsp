<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/css?family=Bungee|Faster+One|Nanum+Gothic" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>

 <a href="${google_url}"><button id="btnJoinGoogle" class="btn btn-primary btn-round"
style="width: 100%">
 <i class="fa fa-google" aria-hidden="true"></i>Google Login
 </button></a> 
<script>
	$(document).ready(function() {
		$("#btnJoinGoogle").click();
	})
</script>


</body>
</html>