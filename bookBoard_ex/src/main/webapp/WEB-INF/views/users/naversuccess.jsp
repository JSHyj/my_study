<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="ko">
<head>
<script type="text/javascript"
  src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js"
  charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<style type="text/css">
html, div, body, h3 {
  margin: 0;
  padding: 0;
}

h3 {
  display: inline-block;
  padding: 0.6em;
}
</style>
<script type="text/javascript">
  $(document).ready(function() {
    var name = ${result}.response.name;
    var email = ${result}.response.email;
    var id = ${result}.response.id;
    var img = ${result}.response.profile_image;
    
    $("#id").attr("value", id);
    $("#name").attr("value", name);
    $("#email").attr("value", email);
    $("#img").attr("value", img);
    
    $("#formAction").submit();
   
    
    });
  //location.href = "${pageContext.request.contextPath}/";
</script>
</head>
<body>


  <div
    style="background-color: #15a181; width: 100%; height: 50px; text-align: center; color: white;">
    <h3>Naver_Login Success</h3>
  </div>
  <br>
  <form action="/users/naversignup" method="post" id="formAction">
  <input type="text" style="text-align: center" id="name" name="name" value="a">
  <input type="text" style="text-align: center" id="email" name="email" value="a">
  <input type="text" style="text-align: center" id="id" name="id" value="a">
  <input type="text" style="text-align: center" id="img" name="img" value="a">
  </form>
<script>
    $(function () {
      $("body").hide();
      $("body").fadeIn(1000);  // 1초 뒤에 사라 지자 
     
      setTimeout(function(){$("body").fadeOut(1000);},1000);d
      setTimeout(function(){location.href= "${pageContext.request.contextPath}/board/list?page=1"},2000);
// 2초 뒤에 메인 화면 으로 가자  
    
    })
  </script>

</body>
</html>