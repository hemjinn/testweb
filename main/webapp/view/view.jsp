<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardDTO" %>
<!DOCTYPE html>
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
    
    // 게시글
    int bd_no = 0;
    if (request.getParameter("bd_no") != null) {
        bd_no = Integer.parseInt(request.getParameter("bd_no"));
    }
    if (bd_no == 0) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('유효하지 않은 게시글입니다.')");
        script.println("</script>");
        response.sendRedirect("board.jsp");
    }

    BoardDTO boardDTO = new BoardDAO().getBoardDTO(bd_no);
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

    <!-- 게시글 조회 화면 -->
    <div class= "container">
        <div class= "row">
            <table class= "table table-stripped" style= "text-align: center; boarder: 1px solid #dddddd">
                <thead>
                    <tr>
                        <th colspan="3" style="background-color: #eeeeee; text-align: center;">게시판 글 보기</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td style="width:20%">글 제목</td>
                        <td colspan="2"><%=boardDTO.getBd_title().replaceAll(" ","&nbsp;") %></td>
                        <%-- xss방지용 
                        <td colspan="2"><%=boardDTO.getBd_title().replaceAll(" ","&nbsp;").replaceAll("<","&lt").replaceAll(">", "&gt;").replaceAll("\n","<br>") %></td><td colspan="2"><%=boardDTO.getBd_title().replaceAll(" ","&nbsp;").replaceAll("<","&lt").replaceAll(">", "&gt;").replaceAll("\n","<br>") %></td>
                        --%>
                    </tr>
                    <tr>
                        <td>작성자</td>
                        <td colspan="2"><%=boardDTO.getUsername().replaceAll(" ","&nbsp;").replaceAll("<","&lt").replaceAll(">", "&gt;").replaceAll("\n","<br>") %></td>
                        <!-- 위에 xss 방지용 참고할 것 -->
                    </tr>
                    <tr>
                        <td>작성일자</td>
                        <td colspan="2"><%=boardDTO.getBd_date()%></td>
                        <!-- 위에 xss 방지용 참고할 것 -->
                    </tr>
                    <tr>
                        <td>내용</td>
                        <td colspan="2" style="min-height:200px; text-align:left;">
                        <%= boardDTO.getBd_content().replaceAll(" ","&nbsp;") %></td>
                        <!-- xss방지용 
                        <%= boardDTO.getBd_content().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>") %></td>
                        -->
                    </tr>

                    <!-- 여기에 업로드된 파일 출력 구현 -->
                    <tr>
                        <td>첨부파일</td>
                        <td colspan="2" style="min-height:200px; text-align:left;">
                        <%
                            // 만약, 첨부파일이 없으면..
                            if (boardDTO.getFile_route() == "/file/upload/null" || boardDTO.getFile_route() == "NULL") {
                        %>
							첨부파일이 없습니다.
                        <%
                            } 
                            else {
						%>
						    <a style="color: blue; text-decoration: underline;" href="<%=boardDTO.getFile_route() %>"><%=boardDTO.getFile_name() %></a>
                        <%
                            }
                        %>
                        </td>
                    </tr>
                </tbody>
            </table>



            <!-- 게시글 수정 및 삭제를 위한 사용자 권한 식별 -->
            <a href="board.jsp" class="btn btn-primary">목록</a>
            <%
                String userEmail = userDao.ssEmail(boardDTO.getUsername());
                if (AEGIuser != null && AEGIuser.equals(userEmail)) {
            %>
                <a href="update.jsp?bd_no=<%=bd_no%>" class="btn btn-warning">수정</a>
                <a href="delAction.jsp?bd_no=<%=bd_no%>" class="btn btn-danger">삭제</a>
            <%
                }
            %>
        </div>
        <button class="btn btn-primary pull-right" onclick="location.href='write.jsp'">글쓰기</button>
    </div>

    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="/js/bootstrap.js"></script>

</body>
</html>