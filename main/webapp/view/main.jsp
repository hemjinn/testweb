<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/css/bootstrap.css"> <!-- 참조  -->
<title>AEGI HACK</title>
</head>
<body>
    <%  // 세션 검사
        String AEGIuser = null;
    	if (session.getAttribute("AEGIuser") != null){
            AEGIuser = (String) session.getAttribute("AEGIuser");
    	}

    	if (AEGIuser == null){
    		response.sendRedirect("../index.jsp");
    	}
	%>

    <!-- 메인메뉴 -->
    <nav class="navbar navbar-default">
        <div class="navbar-header"> <!-- 홈페이지의 로고 -->
            <button type="button" class="navbar-toggle collapsed"
                data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expand="false">
                <span class ="icon-bar"></span> <!-- 줄였을때 옆에 짝대기 -->
                <span class ="icon-bar"></span>
                <span class ="icon-bar"></span>
            </button>
            <a class ="navbar-brand" href="main.jsp">AEGI HACK Online</a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li class="active"><a href="main.jsp">메인</a></li> <!-- 메인 페이지 -->
                <li><a href="board.jsp">게시판</a></li>
            </ul>

            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                <a href="#" class = "dropdown-toggle"
                    data-toggle="dropdown" role ="button" 
                    aria-haspopup="true"
                    <%
	                    UserDAO userDao = new UserDAO();
	                    String userName = userDao.ssName(AEGIuser);
                    %>
                    aria-expanded="false"><%=userName %>님 환영합니다.<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="logoutAction.jsp">로그아웃</a></li>
                        <li><a href="modify.jsp">정보수정</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </nav>

    <div class="container">
    	<div class="jumbotron">
    		<div class ="container">
    			<h1>웹 사이트 소개</h1>
    			<p>AEGI Hack Online에 오신 것을 환영합니다.</p>
    			<button class="btn btn-primary" onclick="alert('AEGI HACK Online 은 모의해킹 연습용 웹 사이트로 간이 서버에서 배포중입니다.\n때문에 자동화 공격(sqlmap, nmap 등) 및 과도한 트래픽을 유발하는 공격은 삼가하여 주시기 바랍니다.')">자세히 알아보기</a>
    		</div>
    	</div>
    </div>

    <div class="container">
    	<div id="myCarousel" class="carousel slide" data-ride="carousel">
    		<ol class="carousel-indicators">
	    		<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
	    		<li data-target="#myCarousel" data-slide-to="1"></li>
	    		<li data-target="#myCarousel" data-slide-to="2"></li>
    		</ol>
    		<div class="carousel-inner">
	    		<div class="item active">
	    			<img src="/images/1.png" height="500" width="1200">
	    		</div>
    		</div>
    		<a class="left carousel-control" href="#myCarousel" data-slide="prev">
    			<span class="glyphicon glyphicon-chevron-left"></span>
    		</a>
    		<a class="right carousel-control" href="#myCarousel" data-slide="next">
    			<span class="glyphicon glyphicon-chevron-right"></span>
    		</a>
    	</div>
    </div>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="/js/bootstrap.js"></script>
</body>
</html>