<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
String s_ID = (String) session.getAttribute("s_ID");
String s_img = (String) session.getAttribute("s_img");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.test1 {
}
.font_color {
	color: #585858;
}
a:hover {
	text-decoration: none;
}
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

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Register</h1>
	</div>
</div>
	
<div class="row">

                <div class="col-lg-12">
                	<div class="panel panel-default">
                		<div class="panel-heading">
                		<div style="height: 25px; overflow:hidden; font-size:1.2em; font-weight:bold; color: black;"><c:out value="${board.title }" /></div>
                		<a href="#"><img src="<c:out value="${board.user_img }" />" style="width:25px; border-radius: 50%;"></a>
                		<a href="#" style="padding:5px; font-size:14px; color: #A4A4A4;"><c:out value="${board.user_id }" /></a>
                		</div>
                		<div class="panel-body">
                			<div class="regdateView"><span class="pull-right" style="color:#bbb"><c:out value="${board.regDate }"/></span></div><br><br>
	                		<div class="panbodyin" style="color: black;"><c:out value="${board.content }" /></div>
		                	
                		</div>
                		<div class="panel-footer">
                			<div class="contentViewReplyWrite">
                				<form action="/board/contentView" method="post" id="replyForm">
                					<input type="hidden" name="rBno" value="<c:out value="${board.bno }" />">
                					<textarea name="reply" id="replyArea" style="width: 88%; height: 60px; float:left;resize: none;"></textarea>
                					<input type="button" value="댓글 쓰기" style="width: 10%; height: 60px; border: none; background-color: #FF8000;" onclick="replySubmit()">
                				</form>
                			</div>
                		</div>
                	</div>	
                </div>
                <script>
                	function replySubmit() {
                		var reply = $("#replyArea").val();
                		if(reply == "") {
                			alert("내용을 입력해주세요.");
                		}else {
                			$("#replyForm").submit();
                		}
                	}
                </script>
                
              
</div>

<div class="row">
								<c:forEach items="${reply}" var="reply">
								<div class="col-lg-12">
                					<div class="panel panel-default">
                						<div class="panel-heading">
                							<a href="#"><img src="<c:out value="${reply.user_img }" />" style="width:30px; border-radius: 50%;"><span id="idChk" style="margin-left: 10px; color:#bbb"><c:out value="${reply.user_id }" /></span></a>
                						</div>
                						
                						<div class="panel-body">
                							<ul class="chat">
                								<li class="left clearfix" data-rno='12'>
                								<div>
                									<div class="header">
                										<small class="pull-right text-muted"><c:out value="${reply.updateDate}" /></small>
                									</div>
                									<c:choose>
                										<c:when test="${reply.del eq 1 }">
                											<p><c:out value="${reply.reply }" /></p>
                										</c:when>
                										<c:when test="${reply.del eq 0 }">
                											<p style="color: red">삭제된 댓글입니다.</p>
                										</c:when>
                									</c:choose>
                								</div>
                								</li>
                							</ul>
                							
                							<c:choose>
                								<c:when test="${reply.del eq 1 }">
                							<button type="button" class="btn btn-default btn-xs" id="" >댓글달기</button>
                							<div style="display:inline">
                							<form action="/board/replyDelete" method="post">
                							<input type="hidden" name="rno" value="<c:out value="${reply.rno }" /> ">
                							<input type="hidden" name="bno" value="<c:out value="${reply.bno }" /> ">
                							<input type="hidden" name="user_id" value="<c:out value="${reply.user_id}"/>">
                							<textarea name="reply" style="display:none"><c:out value="${reply.reply }" /></textarea>
                							<input type="hidden" name="s_ID" value="<%=s_ID%>">
        									<button type="submit" class="pull-right btn btn-warning btn-xs" id="replyDelete">삭제하기</button>
        									</form>
        									
                							<form action="/board/replyModify" method="post">
                							<input type="hidden" name="rno" value="<c:out value="${reply.rno}" />">
                							<input type="hidden" name="bno" value="<c:out value="${reply.bno}" />">
                							<input type="hidden" name="user_id" value="<c:out value="${reply.user_id}"/>">
                							<textarea name="reply" style="display:none"><c:out value="${reply.reply}" /></textarea>
        									<button type="submit" class="pull-right btn btn-default btn-xs" id="replyDelete">수정하기</button>
        									</form>
        									</div>
        									</c:when></c:choose>
                						</div>
                						
                					</div>
								</div>
								</c:forEach>
</div>
<a href="/board/modify?bno=<c:out value="${board.bno}"/>"><button data-oper='modify' class="btn btn-primary">수정하기</button></a>
<a href="#deleteModal" data-toggle="modal"><button data-oper='delete' class="btn btn-danger pull-right" id="deleteBtn">글 삭제하기</button></a>
<a href="/board/list"><button data-oper='list' class="btn btn-default">목록</button></a>


<!-- 모달영역 -->
<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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

<!-- 댓글수정 -->
<div class="modal fade" id="modifyReply" tabindex="-1" role="dialog" aria-labelledby="modifyReplyLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">Modal title</h4>
			</div>
			<div class="modal-body">
				<form role="form" role="form" action="/board/replyModify.do" method="post">
					<input type="hidden" name="rno" value="${modify.rno}">
					<input type="hidden" name="bno" value="${modify.bno}">
					<input type="hidden" name="user_id" value="${modify.user_id}">
					<input type="hidden" name="step" value="${modify.step}">
					<input type="hidden" name="indent" value="${modify.indent}">
					<input type="hidden" name="del" value="${modify.del}">
					<input type="hidden" name="user_img" value="<%=s_img%>">
					<div class="form-gorup">
						<textarea class="form-control" rows="5" name="reply" ><c:out value="${modify.reply}" /></textarea>
					</div>
					<button type="submit" class="btn btn-primary">수정</button>
					<a href="/board/contentView?bno=<c:out value="${board.bno }" />"><button type="button" class="pull-right btn btn-default" data-dismiss="modal">취소</button></a>
				</form>
			</div>
			<div class="modal-footer">
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		
		$("#modifyReply").modal("show");
		
			});
</script>

<%@include file="../includes/footer.jsp" %>
</body>
</html>