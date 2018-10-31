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
.uploadResult {
	width: 100%;
	background-color: gray;
}
.uploadResult ul {
	display:flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}
.uploadResult ul li {
	list-style: none;
	padding: 10px;
	align-content: center;
}
.uploadResult ul li img {
	width: 100px;
}
.uploadResult ul li span {
	color: white;
}
.bigPictureWrapper {
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
	background: rgba(255,255,255,0.5);
}
.bigPicture {
	position: relative;
	display:flex;
	justify-content: center;
	align-items: center;
}
.bigPicture img {
	width: 600px;
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
                			<div class="uploadResult">
								<ul>
								</ul>
							</div>
	                		<div class="panbodyin" style="color: black;"><c:out value="${board.content }" /></div>
		                	<div class="BtnMenu" style="margin-left: 30%; margin-top: 100px; color:black;">
		                		<ul class="margintop-100" style="width: 100%; margin:0 auto; float: left; ">
			                		<li class="likeBtn" style="text-align: center; display:inline; float:left; margin-right: 40px;"><a href="#"><img src="/user/like/like.png" class="likeBtnClass" style="width:50px;"><br><span class="font_color">좋아요</span></a></li>
			                		<li class="likeBtn" style="text-align: center; display:inline; float:left; margin-right: 40px;" ><a href="#"><img src="/user/like/sad.png" class="likeBtnClass" style="width:50px;"><br><span class="font_color">슬퍼요</span></a></li>
			                		<li class="likeBtn" style="text-align: center; display:inline; float:left; margin-right: 21px;"><a href="#"><img src="/user/like/funny.png" class="likeBtnClass" style="width:50px;"><br><span class="font_color">웃겨요</span></a></li>
			                		<li class="likeBtn" style="text-align: center; display:inline; float:left; margin-right: 40px;"><a href="#"><img src="/user/like/seeyouagain.png" class="likeBtnClass" style="width:50px;"><br><span class="font_color">베스트 추천</span></a></li>
		                		</ul>
	                		</div>
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



<div class="bigPictureWrapper">
	<div class="bigPicture">
	</div>      				
</div>

<!-- 실험할것임 성공하면 아래 삭제 -->
<!-- <div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Files</div>
			<div class="panel-body">
				<div class="uploadResult">
					<ul>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div> -->

<script>

//클릭시 이미지창 크게 띄우기
function showImage(fileCallPath) {
	alert(fileCallPath);
	
	$(".bigPictureWrapper").css("display", "flex").show();
	
	$(".bigPicture").html("<img src='/upload/display?fileName="+fileCallPath+"'>").animate({width: '100%', height: '100%'}, 1000);
}

//이미지창 닫기
$(".bigPictureWrapper").on("click", function(e) {
	$(".bigPicture").animate({width: '0%', height: '0%'}, 1000);
	setTimeout(function() {
		$(".bigPictureWrapper").hide();
	}, 1000);
});

</script>

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
                										<c:otherwise>
                											<p style="color: red">삭제된 댓글입니다.</p>
                										</c:otherwise>
                									</c:choose>
                								</div>
                								</li>
                							</ul>
                							<c:choose>
                								<c:when test="${reply.del eq 1 }">
                							<%-- <form action="/board/replyReply" method="post">
                							<input type="hidden" name="rno" value="<c:out value="${reply.rno}" />">
                							<input type="hidden" name="bno" value="<c:out value="${reply.bno}" />">
                							<input type="hidden" name="step" value="<c:out value="${reply.step}" />">
                							<input type="hidden" name="indent" value="<c:out value="${reply.indent}" />">
                							
                							
                							<input type="hidden" name="user_id" value="<%=s_ID%>">
                							<input type="hidden" name="user_img" value="<%=s_img%>">
                							<button type="submit" class="btn btn-default btn-xs" id="" >댓글달기</button>
                							</form> --%>
                							<div style="display:inline">
                							<form action="/board/replyDelete" method="post">
                							<input type="hidden" name="rno" value="<c:out value="${reply.rno }" />">
                							<input type="hidden" name="bno" value="<c:out value="${reply.bno }" />">
                							<input type="hidden" name="user_id" value="<c:out value="${reply.user_id}"/>">
                							<textarea name="reply" style="display:none"><c:out value="${reply.reply}" /></textarea>
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
        									</c:when>
        									</c:choose>
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
				<form role="form" role="form" action="/board/contentView.do" method="post">
					<div class="form-gorup">
						<textarea class="form-control" rows="5" name="content" ><c:out value="${replymodify}" /></textarea>
					</div>
					<button type="button" class="btn btn-primary">수정</button>
					<button type="button" class="pull-right btn btn-default" data-dismiss="modal">취소</button>
				</form>
			</div>
			<div class="modal-footer">
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
</div>

<script type="text/javascript">
	$(document).ready(function() {
		
		var bno = '<c:out value="${board.bno}" />';
		console.log(bno);
		
		$.getJSON("/board/getAttachList", {bno:bno}, function(arr) {
			console.log(arr);
			var str = "";
			$(arr).each(function(i, attach) {
				
				if(attach.fileType) {
					var fileCallPath = encodeURIComponent(attach.uploadPath+ "/s_" + attach.uuid+"_"+attach.fileName);
					
					str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'><div>";
					str += "<img src='/upload/display?fileName="+fileCallPath+"' >";
					str += "</div>";
					str += "</li>";
				}else {
					str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
					str += "<span>"+attach.fileName+"</span><br/>";
					str += "<img src='/user/default-user.png'>";
					str += "</div>";
					str += "</li>";
				}
			});
			$(".uploadResult ul").html(str);
			
		});
		
		$(".uploadResult").on("click","li",function(e) {
			
			console.log("view image");
			
			var liObj = $(this);
			
			var path = encodeURIComponent(liObj.data("path")+"/"+liObj.data("uuid")+"_"+liObj.data("filename"));
			
			if(liObj.data("type")) {
				showImage(path.replace(new RegExp(/\\/g),"/"));
			}else {
				self.location = "/upload/download?fileName="+path; //아직 안만들었음 에러뜸
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