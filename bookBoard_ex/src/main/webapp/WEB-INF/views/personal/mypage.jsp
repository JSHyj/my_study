<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
String s_ID = (String) session.getAttribute("s_ID");
String s_img = (String) session.getAttribute("s_img");
int imgCnt = 0;
int Slider = 0;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

.back-to-top {
	cursor: pointer;
    position: fixed;
    bottom: 20px;
    right: 20px;
    z-index: 500px;
}
.font_color {
	color: #585858;
}
a:hover {
	text-decoration: none;
}
.uploadResult {
	width: 100%;
	background-color: whitesmoke;
}
.uploadResult ul {
	display:flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
	margin:0;
	padding: 0;
}
.uploadResult ul li {
	display: inline;
	list-style: none;
	align-content: center;
	align-items: center;
}
.uploadResult ul li:gt(0) {
	display: hidden;
}
.uploadResult ul li img {
	width: 100%;
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
	width: 100%;
	max-width: 2000px;
}
#imgNextBtn {
	position: absolute;
	cursor: pointer;
	top: 500px;
	background-color: red;
	z-index: 100px;
}
.inlineLI {
	list-style:none;
}
.inlineLi li {
	display:inline;
}
#infoTable tr td {
	width: 300px;
}
#backgroundinfo{
	background-size: cover;
}

#hoverscroll {
	overflow:hidden;
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
        
	<div class="col-lg-12" id="backgroundinfo">
	<button type="button" id="regBtn" class="btn btn-info affix back-to-top btn-circle" ><i class="fa fa-plus"></i></button>
		<h3 class="page-header" style="margin-top: 50px; border-bottom:1px solid #eee;"></h3>
			<div class="panel" style="background-color: rgba(0, 0, 0, 0.2);">
             	<div class="panel-heading text-center" style="border: none; color: white;" >
             		<img src="<c:out value="${info.user_img }" />" style="width: 200px; border-radius:50%; margin:0 auto;">
             		<br><h2><c:out value="${info.user_id }" /></h2>
             		
             		<div class="text-center" style="word-spacing:40px">
             			<table id="infoTable" style="margin-left: auto; margin-right: auto;">
             				<tr>
             					<td>게시물</td>
             					<td>팔로잉</td>
             					<td>팔로워</td>
             				</tr>
             				<tr>
             					<td><c:out value="${boardCnt}" /></td>
             					<td><c:out value="${followerCnt}" /></td>
             					<td><c:out value="${FollowingMe}" /></td>
             			</table>
             			
             		</div>
            	</div>
            </div>
	</div>
</div>
<script>

</script>
<%
String user = request.getParameter("user_id");
if(user.equals(s_ID)) { %>
	
<button class="btn btn-primary" onclick="location.href='/personal/bgChange2?user_id=<%=user %>'">배경이미지 변경</button>
<%}%>
<div class="row" style="margin-top: 30px;">
	<c:forEach items="${list }" var="board">
                <div class="col-md-4">
                	<div class="panel panel-default">
                		<div class="panel-heading">
                		<div style="height: 25px; overflow:hidden"><a href=/board/contentView?bno=<c:out value="${board.bno}"/> style="font-size:1.2em; font-weight:bold; color: black;"><c:out value="${board.title }" /></a></div>
                		<a href="#"><img src="<c:out value="${board.user_img }" />" style="width:25px; border-radius: 50%;"></a>
                		<a href="#" style="padding:5px; font-size:14px; color: #A4A4A4;"><c:out value="${board.user_id }" /></a>
                		</div>
                		<a href=/board/contentView?bno=<c:out value="${board.bno}"/>> 
                		<div class="panel-body" id="hoverscroll" style="overflow:hidden; margin:0 auto; padding:0;">
                		<c:choose>
                		<c:when test="${board.main_img eq 'not' }">
                		<img src="/user/default-image.png"  >
                		</c:when>
                		<c:otherwise>
                		<div style="height: 500px">
                		<img src="/upload/display?fileName=<c:out value="${board.main_img}" />"  >
                		</div>
                		</c:otherwise>
                		</c:choose>
                		</div></a>
                	</div>	
                </div>
                
       <script>
       $("#regBtn").on("click", function() {
			self.location = "/upload/register";
		});
       </script>
                
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
                
                
	</c:forEach>
                
              
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
	//alert(fileCallPath);
	
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

<%-- <div class="row">
								<c:forEach items="${reply}" var="reply">
										<div class="col-lg-10">
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
                							<form action="/board/replyReply" method="post">
                							<input type="hidden" name="rno" value="<c:out value="${reply.rno}" />">
                							<input type="hidden" name="bno" value="<c:out value="${reply.bno}" />">
                							<input type="hidden" name="step" value="<c:out value="${reply.step}" />">
                							<input type="hidden" name="indent" value="<c:out value="${reply.indent}" />">
                							
                							
                							<input type="hidden" name="user_id" value="<%=s_ID%>">
                							<input type="hidden" name="user_img" value="<%=s_img%>">
                							<button type="submit" class="btn btn-default btn-xs" id="" >댓글달기</button>
                							</form>
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
</div> --%>


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
		
		var bg_img = '<c:out value="${info.bg_img}" />';
		$("#backgroundinfo").css("background", "url('/upload/display?fileName=<c:out value="${info.bg_img}" />')");
		console.log("bg_img:"+bg_img);
		
		
		var bno = '<c:out value="${board.bno}" />';
		console.log(bno);
		
		$.getJSON("/board/getAttachList", {bno:bno}, function(arr) {
			console.log(arr);
			var str = "";
			$(arr).each(function(i, attach) {
				
				
				
				if(attach.fileType) {
					
					var fileCallPath = encodeURIComponent(attach.uploadPath+ "/" + attach.uuid+"_"+attach.fileName);
					
					str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'><div>";
					str += "<img src='/upload/display?fileName="+fileCallPath+"' >";
					str += "</div>";
					str += "</li>";
					<%imgCnt = imgCnt + 1; %>
				}else {
					str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
					str += "<span>"+attach.fileName+"</span><br/>";
					str += "<img src='/user/save.png'>";
					str += "</div>";
					str += "</li>";
				}
				$(".btnInsert").html("<button type='button' class='btn btn-success pull-left'>이전</button><button type='button' class='btn btn-success pull-right'>다음</button>");
			});
			$(".uploadResult ul").html(str);
			//$(".uploadResult ul li:gt(0)").css("display", "none");
			console.log("이미지카운트"+<%=imgCnt%>);
			
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