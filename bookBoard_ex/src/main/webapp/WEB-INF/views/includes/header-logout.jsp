<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String user_ID = (String) session.getAttribute("s_ID");
String user_img = (String) session.getAttribute("s_img"); 
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>SB Admin 2 - Bootstrap Admin Theme</title>
    <script src="http://code.jquery.com/jquery-latest.js"></script>
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
    
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Bungee|Faster+One|Nanum+Gothic" rel="stylesheet">
<style>
* {
font-family: 'Nanum Gothic', sans-serif;
}
.fontH {
	font-family: 'Bungee', cursive;
}
</style>
</head>
<body>
    <div id="wrapper">
        <!-- Navigation -->
        <nav class="navbar navbar-default navbar-fixed-top" role="" style="margin-bottom: 0; border-radius: 10px 10px 0px 0px; background-color:#4374D9;"> <!-- #4374D9 -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand pull-right" href="/board/list?page=1" style="color: white;" ><span class="fontH">SQUARE BEANS</span></a>
            </div>

            <!-- /.navbar-header -->
            <ul class="nav navbar-top-links navbar-right">
                    <div class="input-group custom-search-form navbar-left" style="margin-top: 7px; margin-right: 50px; float: left;">
                            <form action="/board/search" method="post" id="searchForm">
                                <div class="input-group-btn">
                                <input type="text" style="width:400px;" class="form-control" placeholder="Search..." id="search" name="search">
                                <button class="btn btn-default" type="button" id="searchBtn">
                                    <i class="fa fa-search"></i>
                                </button>
                            </div>
                            </form>
                    </div>
                    
                    
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-envelope fa-fw"></i> <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-messages">
                        <li>
                            <a href="#">
                                <div>
                                    <strong>John Smith</strong>
                                    <span class="pull-right text-muted">
                                        <em>Yesterday</em>
                                    </span>
                                </div>
                                <div>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque eleifend...</div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <strong>John Smith</strong>
                                    <span class="pull-right text-muted">
                                        <em>Yesterday</em>
                                    </span>
                                </div>
                                <div>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque eleifend...</div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <strong>John Smith</strong>
                                    <span class="pull-right text-muted">
                                        <em>Yesterday</em>
                                    </span>
                                </div>
                                <div>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque eleifend...</div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a class="text-center" href="#">
                                <strong>Read All Messages</strong>
                                <i class="fa fa-angle-right"></i>
                            </a>
                        </li>
                    </ul>
                    <!-- /.dropdown-messages -->
                </li>
                <!-- /.dropdown -->
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-tasks fa-fw"></i> <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-tasks">
                        <li>
                            <a href="#">
                                <div>
                                    <p>
                                        <strong>Task 1</strong>
                                        <span class="pull-right text-muted">40% Complete</span>
                                    </p>
                                    <div class="progress progress-striped active">
                                        <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 40%">
                                            <span class="sr-only">40% Complete (success)</span>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <p>
                                        <strong>Task 2</strong>
                                        <span class="pull-right text-muted">20% Complete</span>
                                    </p>
                                    <div class="progress progress-striped active">
                                        <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" style="width: 20%">
                                            <span class="sr-only">20% Complete</span>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <p>
                                        <strong>Task 3</strong>
                                        <span class="pull-right text-muted">60% Complete</span>
                                    </p>
                                    <div class="progress progress-striped active">
                                        <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%">
                                            <span class="sr-only">60% Complete (warning)</span>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <p>
                                        <strong>Task 4</strong>
                                        <span class="pull-right text-muted">80% Complete</span>
                                    </p>
                                    <div class="progress progress-striped active">
                                        <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100" style="width: 80%">
                                            <span class="sr-only">80% Complete (danger)</span>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a class="text-center" href="#">
                                <strong>See All Tasks</strong>
                                <i class="fa fa-angle-right"></i>
                            </a>
                        </li>
                    </ul>
                    <!-- /.dropdown-tasks -->
                </li>
                <!-- /.dropdown -->
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-bell fa-fw" style="color: white;"></i> <i class="fa fa-caret-down" style="color: white;"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-alerts" id="newComment" >
                        
                        
                    </ul>
                    <!-- /.dropdown-alerts -->
                </li>
                <!-- /.dropdown -->
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <img src='<%=user_img%>' style="width:25px; border-radius: 50%;">
                    </a>
                    <ul class="dropdown-menu dropdown-user">
                        <li><a href="/personal/mypage?user_id=<%=user_ID %>"><i class="fa fa-user fa-fw"></i> MY PAGE</a>
                        </li>
                        <li><a href="/personal/infomation?user_id=<%=user_ID%>"><i class="fa fa-gear fa-fw"></i> 개인정보수정</a>
                        </li>
                        <li class="divider"></li>
						<li><a href="/personal/follow?user_id=<%=user_ID%>"><i class="fa fa-sign-out fa-fw"></i>팔로워관리</a>   </li>
                        <li class="divider"></li>
                        <li><a href="/board/logout"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
                        </li>
                    </ul>
                    <!-- /.dropdown-user -->
                </li>
                <!-- /.dropdown -->
            </ul>
            <!-- /.navbar-top-links -->
            
            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu" style="margin-top: 50px;">
                        <li>
                        <img src="/user/Q.png" style="margin-left: 15px; margin-top: -40px;">
                        </li>
                        <li>
                            <a href="/personal/followFeed?user_id=<%=user_ID %>" onclick="followFeed()" ><i class="fa fa-group fa-fw"></i> 팔로워 피드</a>
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-handshake-o fa-fw" style="color: black"></i> 팔로워 정렬<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="#"><i class="fa fa-heart-o"></i> 좋아요</a>
                                </li>
                                <li>
                                    <a href="#"><i class="fa fa-commenting-o fa-fw"></i> 댓글</a>
                                </li>
                              
                            </ul>
                          </li>
                          <li>
                            <a href="#"><i class="fa fa-send-o fa-fw"></i> 전체피드<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="/confirm/likeOrderAll"><i class="fa fa-heart-o"></i> 좋아요</a>
                                </li>
                                <li>
                                    <a href="/confirm/replyOrderAll"><i class="fa fa-commenting-o fa-fw"></i> 댓글</a>
                                </li>
                              
                            </ul>
                          </li>    
                    </ul> 
                </div>
                <!-- /.sidebar-collapse -->
            </div>
            
            <!-- onclick follow feed -->
            <script>
            function followFeed() {
            	var sessionID = '<%=user_ID%>';
            	
            	$.ajax ({
            		type: 'POST',
            		url: '/confirm/followFeed.do',
            		data: {user_id : sessionID},
            		success: function(result) {
            			
            		}
            	});
            	
            }
            
            </script>
            
            
            
            
            
            
            <script>
                            	var searchForm = $("#searchForm");
                            	
                            	$("#searchBtn").on("click", function() {
                            		var search = $("input[name='search']").val();
                            		if(search == "") {
                            			alert("내용을 입력해주세요.");
                            			return false;
                            		}
                            			searchForm.append(search);
                            			searchForm.submit();
                            		
                            	}) ;
                            </script>

          
                
                <!-- /.sidebar-collapse -->
            </div>
            <!-- /.navbar-static-side -->
        
<script>
$(document).ready(function() {
	var loginID = "<%=user_ID%>";
	console.log(loginID);
	$.ajax({
		type: 'POST',
		url: '/confirm/comment',
		data: { id : loginID },
		success: function(result) {
			
				var str = "<br />";
			if(result != null) {
				$.each(result, function(index, item) {
					
					str += "<div style='padding-left:10px;'><i class='fa fa-comment fa-fw'></i>새로운 댓글이 있습니다.</div>"
					str += "<a href='/board/contentView?bno="+item.bno+"' style='padding:0;'><li style='font-weight:bold; padding-left:10px;'><img src='"+item.user_img+"' style='width:25px; border-radius: 50%'><span style='padding-left:10px'>"+item.user_id+"</span></li>";
					str += "<li style='padding-left:10px; font-size: 12px; height:15px; overflow:hidden;'>"+item.reply+"</li>";
					str += "<li class='divider'></li></a>";
					
					
					console.log(index +"," + item.rno);
					console.log(index +"," + item.bno);
					console.log(index +"," + item.reply);
					console.log(index +"," + item.user_id);
					console.log(index +"," + item.replyDate);
					console.log(index +"," + item.updateDate);
					console.log(index +"," + item.del);
					console.log(index +"," + item.user_img);
					console.log(index +"," + item.writer);
				});
				
				$("#newComment").html(""+str);
			}else {
				$("#newComment").html("새로운 소식이 없습니다.<br>" +str);
			}
				
			}
		
	});
});
</script>
               <div id="page-wrapper" style="border-right: black;">
       
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</body>
</html>