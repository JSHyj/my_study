<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
String s_ID = (String) session.getAttribute("s_ID");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.uploadResult {
		width: 100%;
		background-color: gray;
	}
	.uploadResult ul {
		display: flex;
		flex-flow: row;
		justify-content: center;
		align-items: center;
	}
	.uploadResult ul li {
		list-style: none;
		padding: 10px;
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
	
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Board Register</div>
			<div class="panel-body">
				<form role="form"  action="/personal/bgChange" method="post">
					<div class="form-gorup">
						<label>작성자</label>
						<input class="form-control" name="user_id" value="<%=s_ID %>" readonly>
					</div>
					<div class="margin_top5px" style="margin-top:15px"></div>
					<button type="button" data-oper='modify' class="btn btn-primary">선택</button>
					<button type="button" data-oper='cancel' class="btn btn-default">취소</button>
					
				</form>				
			</div>
		</div>
	</div>
</div>
</div>
<div class="bigPictureWrapper">
<div class="bigPicture"></div>
</div>
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">File Attach</div>
			
			<div class="panel-body">
				<div class="form-group uploadDiv">
					<input type="file" name="uploadFile" multiple="multiple">
				</div>
				
				<div class="uploadResult">
					<ul>
				
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
					$(document).ready(function() {
						
						var result = "${result}";
						
						if(result != "") {
							alert(result);
							location.href="/board/list";
						} // 세션값과 다른 아이디로 들어온 경우 리턴
						
						var formObj = $("form");
						$('button').on("click",function(e) {
							
							e.preventDefault();
							
							var operation = $(this).data("oper");
							console.log(operation);
							
							if(operation === 'modify'){
								
								console.log("submit clicked");
								
								var str ="";
								var radio = $("input[name='bg_img']");
								
								/* $(".uploadResult ul li").each(function(i, obj) {
									var jobj = $(obj);
									
									console.dir(jobj);
									
									str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
									str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
									str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
									str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
								}); */
								formObj.append(radio)
								formObj.append(str)
								formObj.submit();
							}else if(operation === 'cancel') {
								self.location ="/personal/mypage?user_id=<%=s_ID%>";
								return;
							}
							
							formObj.submit();
							
						});
					
					
					(function() {
						
						var user_id = '<c:out value="${user_id}" />';
						$.getJSON("/personal/getAttachList", {user_id: user_id}, function(arr) {
							
							console.log(arr);
							var str = "";
							
							$(arr).each(function(i, attach) {
								
								if(attach.fileType) {
									
									var fileCallPath = encodeURIComponent(attach.uploadPath+ "/" + attach.uuid+"_"+attach.fileName);
									
									str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'><div>";
									str += "<span>" + attach.fileName + "</span>";
									str += "<img src='/upload/display?fileName="+fileCallPath+"' >";
									str += "<input type='radio' name='bg_img' value='"+fileCallPath+"' checked/>배경이미지로 설정";
									str += "</div>";
									str += "</li>";
								}else {
									str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
									str += "<span>"+attach.fileName+"</span><br/>";
									str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image'";
									str += " class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
									str += "<img src='/user/default-user.png'>";
									str += "</div>";
									str += "</li>";
								}
							});
								$(".uploadResult ul").html(str);
							
						});
						
					})();
					
					var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
					var maxSize = 5242880; //5MB
					
					function checkExtension(fileName, fileSize) {
						if(fileSize >= maxSize) {
							alert("파일 사이즈 초과");
							return false;
						}
						
						if(regex.test(fileName)) {
							alert("해당 종류의 파일은 업로드할수 없습니다.");
							return false;
						}
						return true;
					}
					
					$("input[type='file']").change(function(e) {
						
						var formData = new FormData();
						var inputFile = $("input[name='uploadFile']");
						var files = inputFile[0].files;
						
						for(var i = 0; i < files.length; i++) {
							if(!checkExtension(files[i].name, files[i].size)) {
								return false;
							}
							formData.append("uploadFile", files[i]);
						}
						$.ajax({
							url:'/upload/uploadAjaxAction',
							processData: false,
							contentType: false,
							data: formData, 
							type: 'POST',
							dataType: 'json',
							success: function(result) {
								console.log(result);
								showUploadResult(result);
							}
						});
					});
					
					function showUploadResult(uploadResultArr) {
						
						if(!uploadResultArr || uploadResultArr.length == 0) { return; }
						var uploadUL = $(".uploadResult ul");
						var str = "";
						$(uploadResultArr).each(function(i, obj) {
							
							if(obj.image) {
								var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
								
								str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
								str += "<span>"+obj.fileName+"</span>";
								str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
								str += "<input type='radio' name='bg_img' value='"+fileCallPath+"' checked/>메인이미지로 설정";
								str += "<img src='/upload/display?fileName="+fileCallPath+"'>";
								str += "</div>";
								str += "</li>";
								
							}else {
								var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
								var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
								
								str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
								str += "<span>"+ obj.fileName + "</span>";
								str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
								str += "<img src='/user/default-user.png'></a>";
								str += "</div>";
								str += "</li>";
							}
							
						});
						uploadUL.append(str);
					}
					
					
					$(".uploadResult").on("click", "button", function(e) {
						console.log("delete file");
						
						if(confirm("remove this file?")) {
							
							var targetLi = $(this).closest("li");
							targetLi.remove();
							//업로드리절트의 버튼을 클릭하면  컨펌창이 뜨고 확인을 누르면 아래가 실행된다.
							//$(this).closest("li") <--누른 버튼의 하위 li를 누르면 리무브한다 
							
						}
						
					});
					
					}); // readyFunction
					
					
					
				</script>
<%@include file="../includes/footer.jsp" %>
</body>
</html>