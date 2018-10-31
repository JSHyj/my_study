<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/css?family=Bungee|Faster+One|Nanum+Gothic" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
<!-- Latest compiled and minified JavaScript -->
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
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
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js" charset="utf-8"></script>
  <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script>
function loginNext() {
	var uID = $("#id").val();
	var pw = $("#password").val();
	if(pw=="") {
		$("#chkMsg").html("비밀번호를 입력해주세요.");
		$("#chkMsg").attr("class","colorRed");
	}else {
		$("#chkMsg").html("");
	}
	if(uID == ""){
		$("#chkMsg").html("아이디를 입력해주세요.");
		$("#chkMsg").attr("class","colorRed");
	}
	
	if(uID != "") {
		$("#chkMsg").html("아이디진입");
		if(pw!="") {
			$("#chkMsg").html("비밀번호진입");
			$.ajax({
				type: 'POST',
				url: '/board/login_page.do',
				data: {id : uID, password : pw},
				success: function(result) {
					if(result==1) {
						$("#loginForm").submit();
					}else if(result==2) {
						$("#chkMsg").html("존재하지 않는 아이디입니다.");
						$("#chkMsg").attr("class","colorRed");
					}else if(result==3) {
						$("#chkMsg").html("비밀번호가 틀렸습니다.");
						$("#chkMsg").attr("class","colorRed");
					}else {
						$("#chkMsg").html("로그인 오류");
					}
				}
			})
		}else if(pw=="") {
			$("#chkMsg").html("비밀번호를 입력해주세요.");
			$("#chkMsg").attr("class","colorRed");
		}
	}else if(uID == ""){
		$("#chkMsg").html("아이디를 입력해주세요.");
		$("#chkMsg").attr("class","colorRed");
	}
}
</script>


<%
String s_Id = null;
if(session.getAttribute("s_ID") != null) {
	s_Id = (String) session.getAttribute("s_ID");
	System.out.println(s_Id);
}

if(s_Id != null) {%>
<script>
alert("이미 로그인 되어 있습니다.");
location.href="/board/list?page=1";
</script>

<%
}
%>


<style>
body {
	background-color: #D9D6FF;
}
.colorRed {
	color: red;
}
.pageIntro {
	width: 100%;
	margin: 0 auto;
	text-align: center;
	font-family: 'Bungee', cursive;
	font-size: 3em;
}
.bigQ {
	font-size: 2em;
}
.login_box {
	width: 400px;
	height: 400px;
	background-color: whitesmoke;
	margin: 0 auto;
}
.login_content {
	padding-top: 15px;
	text-align: center;
	font-family: 'Nanum Gothic', sans-serif;
	font-weight: lighter;
}
.login_form {
	margin: 0 auto;
	padding-top: 15px;
	width: 90%;
}
#loginForm > input {
	width: 358px;
	height: 40px;
	padding-left: 10px;
	padding-right: 10px;
	border: 1px solid #aaa;
	opacity: 0.5;
}
#id {
	display: block;
	background-image: url('/user/id.png'); 
	background-repeat: no-repeat; 
	background-position: 95%; 
	background-size: 15px;
}
#password {
	display: block;
	background-image: url('/user/pw.png'); 
	background-repeat: no-repeat; 
	background-position: 95%; 
	background-size: 18px;
}
button {
	font-family: 'Nanum Gothic', sans-serif;
}
.margin-botoom {
	margin-bottom: 5px;
}
</style>
</head>
<body>
<div class="pageIntro">
<span>S</span><span class="bigQ">Q</span><span>UARE</span><span class="spanup"> BEANS</span></div>
	<div class="login_box">
		<div class="login_content">
			<h4 class="login-title">로그인</h4>
			<div class="login_form">
				<form action="/board/login_page" method="post" id="loginForm">
					<input type="text" placeholder="아이디" name="user_id" id="id"><br>
					<input type="text" placeholder="비밀번호" name="user_pw" id="password"><br>
					<button type="button" class="btn btn-primary pull-right" onclick="loginNext()"><i class="fa fa-sign-in fa-fw"></i>로그인</button>
				</form>
				<br><br>
				<div class="marginBottom15px" style="margin-bottom:15px;"><span id="chkMsg"></span></div>
				<!-- 네이버아이디로 로그인 -->
				<div id="naver_login" style="text-align:center"><a href="/users/naverlogin">
				<button type="button" class="btn btn-success" style="width:360px">
				<span class="pull-left" style="font-weight:bold; font-size:1.3em; width: 15px;  text-align: center;">N</span>
				<span class="text-center" style="vertical-align:middle; font-size:15px;">네이버아이디로 로그인</span></button></a>
				</div>
				<!-- <img width="350" height="50px" src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png"/> -->
				<div class="margin-botoom"></div>
				
				<!-- 구글아이디로 로그인 -->
				<div id="google" style="text-align:center"><a href="/board/ggLogin">
				<button type="button" class="btn btn-warning" style="width:360px">
				<span class="pull-left" style="font-weight:bold; font-size:1.3em; width: 15px; text-align:center;">G</span>
				<span class="text-center" style="vertical-align:middle; font-size: 15px">구글아이디로 로그인</span></button></a>
				</div>
				
				<div class="join_go" style="margin-top:5px;">
					<a href="/board/join_page" class="pull-left">회원가입</a>
				</div>
			</div>
		</div>
	</div>

</body>
</html>