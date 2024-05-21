<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardDTO" %>
<%@ page import="java.util.ArrayList" %>
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
        // 게시글 목록 번호 불러오기
    	int pageNumber = 1;
        if (request.getParameter("pageNumber") != null) {
            pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
                    </ul>
                </li>
            </ul>
        </div>
    </nav>



	<!-- 게시판 검색 -->
	<div class="container">
		<div class="row">
			<form method="post" name="search" action="searchbbs.jsp">
				<table class="pull-right">
					<tr>
						<td>
							<select class="form-control" name="searchField">
								<option value="0">선택</option>
								<option value="bd_title">제목</option>
								<option value="username">작성자</option>
							</select>
						</td>
						<td>
							<input type="text" class="form-control" placeholder="검색어 입력" name="searchText" maxlength="50">
						</td>
						<td><button type="submit" class="btn btn-success">검색</button></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
    
	
	
	<!-- 게시판 목록 -->
    <div class= "container">
    	<div class= "row">
    	    <table class= "table table-stripped" style= "text-align: center; boarder: 1px solid #dddddd">
    	    	<thead>
    	    	<tr>
    	    		<th style= "background-color: #eeeeee; text-align: center;">번호</th>
    	    		<th style= "background-color: #eeeeee; text-align: center;">제목</th>
    	    		<th style= "background-color: #eeeeee; text-align: center;">작성자</th>
    	    		<th style= "background-color: #eeeeee; text-align: center;">작성일</th>
    	    	</tr>
    	    	</thead>
    	    	<tbody>
    	    		<tr>
    	    			<%
    	    				BoardDAO boardDAO = new BoardDAO();
    	    				ArrayList<BoardDTO> list = boardDAO.getList(pageNumber);
    	    				for (int i =0; i<list.size(); i++){
    	    			%>
    	    			<tr>
    	    				<td><%= list.get(i).getBd_no() %></td>
    	    				<td><a href ="view.jsp?bd_no=<%= list.get(i).getBd_no() %>"><%= list.get(i).getBd_title() %></a></td>
    	    				<td><%= list.get(i).getUsername() %></td>
    	    				<td><%= list.get(i).getBd_date() %></td>
    	    			</tr>	
    	    			<%
    	    				}
    	    			%>
    	    		</tr>
    	    	</tbody>
    	    </table>
            <!-- 페이징 -->
    	    <div style="width:100%; text-align:center;">
            <%
    	    	if(pageNumber != 1){
    	    %>		
    	    	    <a href= "board.jsp?pageNumber=<%=pageNumber -1%>" class="btn btn-warning btn-arraw-left">이전</a>
    	    <% 
    	    	}
    	    %>
                <a href= "board.jsp?pageNumber=<%=pageNumber%>" class="btn btn-light "><%=pageNumber%></a>
            <%
                if(boardDAO.nextPage(pageNumber + 1)){
            %>	
    	    	<a href= "board.jsp?pageNumber=<%=pageNumber +1%>" class="btn btn-success btn-arraw-left">다음</a>
    	    <% 
    	    	}
    	    %>
    	    </div>
    	</div>
    	<button class="btn btn-primary pull-right" onclick="location.href='write.jsp'">글쓰기</button>
    </div>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="/js/bootstrap.js"></script>
</body>
</html>