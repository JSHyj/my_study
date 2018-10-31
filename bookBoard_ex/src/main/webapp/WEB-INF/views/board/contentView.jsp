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


.uploadFile {
	width: 100%;
	background-color: #ccc;
}
.uploadFile ul {
	display:flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
	margin:0;
	padding: 0;
}
.uploadFile ul li {
	display: inline;
	list-style: none;
	align-content: center;
	align-items: center;
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

</style>
</head>
<body>
<%
if(s_ID == null) {%>
<script>
alert("먼저 로그인을 해주세요.");
location.href="/board/login_page";
</script> 
<%}else { %>
<%@include file="../includes/header-logout.jsp" %>
<%} %>

<div class="row">
	<div class="col-lg-12" style="margin-top: 100px;">
		
	</div>
</div>
<div class="row container-fluid">
				<div class="col-lg-3"></div>
                <div class="col-lg-6">
                	<div class="panel panel-default">
                		<div class="panel-heading">
                		<div style="height: 25px; overflow:hidden; font-size:1.2em; font-weight:bold; color: black;"><c:out value="${board.title }" /></div>
                		<form action="/personal/follow.do">
						<input type="hidden" value="${board.user_id}" name="follow_id" id="follow_id">
						<input type="hidden" value="${board.user_img }" name="follow_img">
                		
                		<c:choose>
                			<c:when test="${board.user_id eq sessionScope.s_ID }">                			
                			</c:when>
                			<c:otherwise>
                		<button type="button" id="followBtn" class="btn btn-default pull-right" style="margin-top: -10px;"></button>
                			</c:otherwise>
                		</c:choose>
                		</form>
                		
                		
                		<script>
                			$("#followBtn").on("click", function() {
                				
                				console.log("팔로우버튼온클릭")
                				
                				var fol_id = $("input[name='follow_id']").val();
                				var fol_img = $("input[name='follow_img']").val();;
                				
                				
                				console.log("fol_id"+fol_id);
                				console.log("fol_img"+fol_img);
                			
                				$.ajax({
                					type: 'POST',
                					url: '/personal/follow.do',
                					data: {following :  fol_id, follow_img : fol_img},
                					success: function(result) {
                						
                						console.log("follbtn result"+ result)
                						
                						if(result == 1) {
                							//언팔->팔로우
                							$("#followBtn").html("언팔로우");
                							$("#followBtn").attr("class", "btn btn-warning pull-right");
                						}else if (result == 2) {
                							//팔로우->언팔
                							$("#followBtn").html("팔로우");                							
                							$("#followBtn").attr("class", "btn btn-default pull-right");

                						}
                					}
                				});
                			});
                		</script>
                		
                		
                		<a href="#"><img src="<c:out value="${board.user_img }" />" style="width:25px; border-radius: 50%;"></a>
                		<a href="#" style="padding:5px; font-size:14px; color: #A4A4A4;"><c:out value="${board.user_id }" /></a>
                		
                		</div>
                		<div class="panel-body">
                			<div class="regdateView"><span class="pull-right" style="color:#bbb"><c:out value="${board.regDate }"/></span></div><br><br>
           
                				
                				<div class="uploadResult">
									<ul>
									</ul>
								</div>
								<div class="btnInsert" style="margin-botton: 15px; display: inline-block"></div>
								
								
	                		<div class="panbodyin" style="color: black;"><pre style="background-color: white; border: none;"><c:out value="${board.content}" /></pre></div>
                		</div>
                		<div class="panel-footer">
                			
                			
                			<input type="hidden" class="bno" value="<c:out value="${board.bno }" />">
                			<input type="hidden" class="writer" value="<c:out value="${board.user_id }" />">
                			<input type="hidden" class="user_id" value="<%=s_ID %>" >
                			
                			<input type="hidden" class="like" value="like">
                			<button type="button" class="emotionBtn" id="likeBtn" style="border:none; background-color:transparent;"><img id="likeBtnImg" src="/user/like/love.png" style="width:35px; opacity: 0.5; "></button>
                			
                			
                		</div>
                	</div>	
                </div>
                <div class="col-lg-3"></div> 
</div>

						<script>
						$("#likeBtn").on("click", function() {
							
							var bno = $(".bno").val();
							var writer = $(".writer").val();
							var user_id = $(".user_id").val();
							var like = $(".like").val();
							
							console.log("bno:"+bno);
							console.log("writer:"+writer);
							console.log("user_id:"+user_id);
							console.log("like:"+like);
							
							$.ajax({
								type: 'POST',
								url: '/personal/emotionlike',
								data: {bno : bno, user_id : user_id, writer : writer},
								success: function(result) {
									console.log("like btn result"+result);
									
									if(result==1) {
										$("#likeBtnImg").attr("src", "/user/like/loveC.png");
									}else if(result==0) {
										$("#likeBtnImg").attr("src", "/user/like/love.png");
									}
								}
							});
						});
							var emotion = $(this).find('input.emotion').val();
							var user_id = $(this).find('input.user_id').val();
							var writer = $(this).find('input.writer').val();
							var bno = $(this).find('input.bno').val();
							
						
						
						</script>
						

<div class="bigPictureWrapper">
	<div class="bigPicture">
	</div>      				
</div>


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

<div class="row" style="margin-top: 30px;">
	<div class="col-lg-3"></div>
		<div class="col-lg-6">
		<div class="panel panel-default">

		<div class="uploadFile" style="background-color: #ccc; height: 100px;">
			<ul>
			
			</ul>
		</div>

		</div>
		</div>
	<div class="col-lg-3"></div>
</div>


<div class="row container-fluid">
	<div class="col-lg-3"></div>
	<div class="col-lg-6">
		<div class="panel panel-default">
		<form action="/board/contentView" method="post" id="replyForm">
			<input type="hidden" name="rBno" value="<c:out value="${board.bno }" />">
			<input type="hidden" name="writer" value="<c:out value="${board.user_id }"/>">
			<textarea name="reply" id="replyArea" style="width: 85%; height: 60px; float:left;resize: none;"></textarea>
			<input type="button" value="댓글 쓰기" style="width: 15%; height: 60px; border: none; background-color: #FF8000;" onclick="replySubmit()">
		</form>
		</div>
	</div>
	<div class="col-lg-3"></div>
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


						<c:forEach items="${reply}" var="reply">
<div class="row container-fluid">
							<div class="col-lg-3"></div>
								<div class="col-lg-6">
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
						<div class="col-lg-3"></div>
</div>
								</c:forEach>
<div class="row">
<div class="col-lg-3"></div>
<div class="col-lg-6">
<a href="/board/modify?bno=<c:out value="${board.bno}"/>"><button data-oper='modify' class="btn btn-primary">수정하기</button></a>
<a href="#deleteModal" data-toggle="modal"><button data-oper='delete' class="btn btn-danger pull-right" id="deleteBtn">글 삭제하기</button></a>
<a href="/board/list?page=1"><button data-oper='list' class="btn btn-default">목록</button></a>
</div>
<div class="col-lg-3"></div>

</div>								

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
		
		var sessionID = "<%=s_ID%>";
		var bno = "<c:out value="${board.bno}" />";
		//var writer = "<c:out value="${board.user_id}" />";
		
		console.log("sessionID" + sessionID);
		console.log("bno:"+bno);
		
		$.ajax({
			type: 'POST',
			url: '/personal/emotionChk.do',
			data: {sessionID : sessionID, bno : bno},
			success: function(result) {
				console.log("emotion result:" +result)
				console.log("emotion like result:" +result.like)
				
				if(result != null) {
					console.log("emotion result not null");
					
					if(result.like == 0) {
						console.log("result.like 0");
						$("#likeBtnImg").attr("src", "/user/like/love.png");
					}else if (result.like == 1){
						console.log("result.like 1");
						$("#likeBtnImg").attr("src", "/user/like/loveC.png");
					}
					if(result.fun == 0) {
						console.log("result.fun == 0");
						$("#FunBtnImg").attr("src", "/user/like/fun.png");
					}else if (result.fun == 1){
						console.log("result.fun 1");
						$("#FunBtnImg").attr("src", "/user/like/funC.png");
					}
					if(result.sad == 0) {
						console.log("result.sad == 0");
						$("#SadBtnImg").attr("src", "/user/like/blur.png");
					}else if (result.sad == 1){
						console.log("result.sad 1");
						$("#SadBtnImg").attr("src", "/user/like/blurC.png");
					}
					
				}
					
			}
		});
		
		
		var following = '<c:out value="${board.user_id}" />';
		console.log("following"+following);
		var viewer = "<%=s_ID %>";
		var followBtn = $("#followBtn");
		console.log("viewer"+viewer);
		console.log("followbtn"+ followBtn)
		
		$.ajax({
			type: 'POST',
			url: '/personal/followChk.do',
			data: {user_id : viewer, following : following},
			success: function(result) {
				if(result == 1) {
					$("#followBtn").html("언팔로우");
					$("#followBtn").attr("class", "btn btn-default pull-right")
				}else if(result == 0) {
					$("#followBtn").html("팔로우");
					$("#followBtn").attr("class", "btn btn-success pull-right")
				}else if (result == -1) {
					$("#followBtn").html("");
				}
			}
		});
		
		
		var bno = '<c:out value="${board.bno}" />';
		console.log(bno);
		
		$.getJSON("/board/getAttachList", {bno:bno}, function(arr) {
			console.log(arr);
			var str = "";
			var file = "";
			$(arr).each(function(i, attach) {
				
				
				
				if(attach.fileType) {
					
					var fileCallPath = encodeURIComponent(attach.uploadPath+ "/" +attach.uuid+"_"+attach.fileName);

					
					str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'><div>";
					str += "<img src='/upload/display?fileName="+fileCallPath+"' >";
					str += "</div>";
					str += "</li>";
					$(".uploadResult ul").html(str);
					
				}else {
					
					var fileCallPath = encodeURIComponent(attach.uploadPath+ "/" +attach.uuid+"_"+attach.fileName);
					
					file += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"
					+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
					
					file += "<span>"+attach.fileName+"</span><br/>";
					file += "<a href='/upload/download?fileName="+fileCallPath+"'><img src='/user/save.png'></a>";
					file += "</div>";
					file += "</li>";
					$(".uploadFile ul").html(file);
				}
			});
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