<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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

<script>
function idChk() {

	var uID = $("#id").val();
	var msg = $("#chkMsg");
	if(uID == "") {
		$("#chkMsg").html("아이디를 입력해주세요.");
		msg.attr("class", "colorRed");
		$("#id").attr("class","idIMG")
	}
	else if(/^[a-zA-Z0-9]{5,12}$/.test(uID)) {
		$.ajax({
			type: 'GET',
			url: '/board/join_pageChk?user_id='+uID,
			dataType: "text",
			success: function(result) {
				if(result==0) {
					$("#chkMsg").html("사용할 수 있는 아이디입니다.");
					$("#id").attr("class","idSuccess");
					msg.attr("class", "colorGreen");
				}else {
					$("#chkMsg").html("중복된 아이디입니다.");
					msg.attr("class", "colorRed");
					$("#id").attr("class","idfail");
				}
			}
		})
	}
	else {
		$("#chkMsg").html("아이디는 숫자와 영문자로 5~12자리를 사용해야 합니다.");
		msg.attr("class", "colorRed");
		$("#id").attr("class","idfail")
	}
	
}
function pwChk() {
	var pw1 = $("#password1").val();
	var pw2 = $("#password2").val();
	
	if(pw1 != pw2) {
		$("#chkMsg").html("비밀번호가 일치하지 않습니다.");
		$("#chkMsg").attr("class", "colorRed");
		$("#password1").attr("class","idfail");
		$("#password2").attr("class","idfail");
		
	}else if (pw1 == pw2 && pw1 != "") {
		
		if(!/^[a-zA-Z0-9]{6,15}$/.test(pw1) || !/^[a-zA-Z0-9]{6,15}$/.test(pw2)) {
			$("#chkMsg").html("비밀번호는 숫자와 영문자조합으로 6~15자리를 사용해야합니다.");
			$("#password1").attr("class","idfail");
			$("#password2").attr("class","idfail");	
		}
		else{
			$("#chkMsg").html("");
			$("#password1").attr("class","idSuccess");
			$("#password2").attr("class","idSuccess");	
		}
	}else if(pw1=="" || pw2 =="") {
		$("#chkMsg").html("비밀번호란을 확인해주세요.");
		$("#password1").attr("class","passwordImag");
		$("#password2").attr("class","passwordImag");
	}
	
}
function submitFunction() {
	var Btn = $("#submitBtn");
	var form = $("#joinForm");
	
	var uID = $("#id").val();
	var pw1 = $("#password1").val();
	var pw2 = $("#password2").val();
	var uName = $("#name").val();
	var uEmail = $("#email").val();
	
	if(pw1 != pw2) {
		$("#chkMsg").html("비밀번호가 일치하지 않습니다.");
		$("#chkMsg").attr("class", "colorRed");
	}else if (pw1 == "" || pw2 == "") {
		$("#chkMsg").html("비밀번호란을 확인해주세요.");
		$("#chkMsg").attr("class", "colorRed");
	}else if(!/^[a-zA-Z0-9]{6,15}$/.test(pw1) || !/^[a-zA-Z0-9]{6,15}$/.test(pw2)) {
		$("#chkMsg").html("비밀번호는 6~15자리를 사용해야합니다.");
		$("#password1").attr("class","idfail");
		$("#password2").attr("class","idfail");	
	}else {
		$("#password1").attr("class","idSuccess");
		$("#password2").attr("class","idSuccess");	
	}
	if(uName == "") {
		$("#chkMsg").html("이름을 입력해주세요.");
		$("#chkMsg").attr("class", "colorRed");
		uName.focus();
	}
	if(uEmail == "") {
		$("#chkMsg").html("이메일을 입력해주세요.");
		$("#chkMsg").attr("class", "colorRed");
		$("#name").focus();
	}
	
	
	if(uID != "" && pw1 != "" && pw2 != "" && uName != "" && uEmail != "") {
		if(pw1 == pw2 && /^[a-zA-Z0-9]{6,15}$/.test(pw1) && /^[a-zA-Z0-9]{6,15}$/.test(pw2)) {
			
			$("#password1").attr("class","idSuccess");
			$("#password2").attr("class","idSuccess");	
			
			if(/^[a-zA-Z0-9]{5,12}$/.test(uID)) {
				$.ajax({
					type: 'GET',
					url: '/board/join_pageChk?user_id='+uID,
					dataType: "text",
					success: function(result) {
						if(result==0) {
							$("#joinForm").submit();
						}else {
							$("#chkMsg").html("중복된 아이디입니다.");
							msg.attr("class", "colorRed");
							$("#id").attr("class","idfail")
						}
					}
				})
			}
			if(uID == "") {
				$("#chkMsg").html("아이디를 입력해주세요.");
				msg.attr("class", "colorRed");
				$("#id").attr("class","idIMG");
				uID.focus();
			}
			else if(!/^[a-zA-Z0-9]{5,12}$/.test(uID)) {
				$("#chkMsg").html("아이디는 숫자와 영문자로 5~12자리를 사용해야 합니다.");
				msg.attr("class", "colorRed");
				$("#id").attr("class","idfail")
			}
		}else if(pw1 != pw2) {
			$("#chkMsg").html("비밀번호가 일치하지 않습니다.");
			$("#chkMsg").attr("class", "colorRed");
			
		}else if(!/^[a-zA-Z0-9]{6,15}$/.test(pw1) || !/^[a-zA-Z0-9]{6,15}$/.test(pw2)) {
			$("#chkMsg").html("비밀번호는 숫자와 영문자조합으로 6~15자리를 사용해야합니다.");
			$("#password1").attr("class","idfail");
			$("#password2").attr("class","idfail");	
		}
	}
}

</script>    

<style>
body {
	background-color: #D9D6FF;
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
	height: 500px;
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
#joinForm > input {
	width: 358px;
	height: 40px;
	padding-left: 10px;
	padding-right: 10px;
	border: 1px solid #aaa;
	opacity: 0.5;
}
.idIMG {
	display: block;
	background-image: url('/user/id.png'); 
	background-repeat: no-repeat; 
	background-position: 95%; 
	background-size: 15px;
}
.idSuccess {
	display: block;
	background-image: url('/user/yes.png'); 
	background-repeat: no-repeat; 
	background-position: 95%; 
	background-size: 15px;
}
.idfail {
	display: block;
	background-image: url('/user/close.png'); 
	background-repeat: no-repeat; 
	background-position: 95%; 
	background-size: 15px;
}
.passwordImag {
	display: block;
	background-image: url('/user/pw.png'); 
	background-repeat: no-repeat; 
	background-position: 95%; 
	background-size: 18px;
}
#name {
	display: block;
	background-image: url('/user/id.png'); 
	background-repeat: no-repeat; 
	background-position: 95%; 
	background-size: 15px;
}
#email {
	display: block;
	background-image: url('/user/email.png'); 
	background-repeat: no-repeat; 
	background-position: 95%; 
	background-size: 15px;
}
.colorRed {
	color: red;
}
.colorGreen {
	color: green;
}
</style>
</head>
<%
String s_Id = (String) session.getAttribute("s_ID");

if(s_Id != null) {%>
<script>
alert("이미 로그인 되어 있습니다.");
location.href="/board/list";
</script>

<%
}
%>

<body>
<div class="pageIntro">
<span>S</span><span class="bigQ">Q</span><span>UARE</span><span class="spanup"> BEANS</span></div>
	<div class="login_box">
		<div class="login_content">
			<h4 class="login-title">회원가입</h4>
			<div class="login_form">
				<form action="/board/join_page" method="post" id="joinForm">
					<input type="text" placeholder="아이디" name="user_id" id="id" class="idIMG" onkeyup="idChk()"><br>
					<input type="password" placeholder="비밀번호" name="user_pw" id="password1" class="passwordImag" onkeyup="pwChk()"><br>
					<input type="password" placeholder="비밀번호 확인" name="password2" id="password2" class="passwordImag" onkeyup="pwChk()"><br>
					<input type="text" placeholder="이름" name="user_name" id="name"><br>
					<input type="email" placeholder="이메일" name="user_email" id="email"><br>
					<span id="chkMsg" class="pull-left"></span>
					<br><br>
					<button type="button" class="btn btn-primary pull-right" id="submitBtn" onclick="submitFunction()"><i class="fa fa-sign-in fa-fw"></i>회원가입</button>
				</form>
				<div class="join_go">
				</div>
			</div>
		</div>
	</div>
</body>
</html>