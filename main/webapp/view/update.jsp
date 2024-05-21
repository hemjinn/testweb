<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardDTO" %>
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

        if (!AEGIuser.equals(boardDTO.getUsername())) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('권한이 없습니다.')");
            script.println("</script>");
            response.sendRedirect("board.jsp");
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
                    aria-expanded="false"><%=AEGIuser%>님 환영합니다.<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="logoutAction.jsp">로그아웃</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </nav>

    <!-- 게시글 수정 -->
    <div class= "container">
    	<div class= "row">
    		<form method="post" action="updateAction.jsp?bd_no=<%=bd_no%>" enctype="multipart/form-data" accept-charset="UTF-8">
    			<table class= "table table-stripped" style= "text-align: center; boarder: 1px solid #dddddd">
	    	    	<thead>
		    	    	<tr>
		    	    		<th colspan= "2" style= "background-color: #eeeeee; text-align: center;">게시판 글쓰기 양식</th>
		    	    	</tr>
	    	    	</thead>
			    	<tbody>
			    		<tr>
			    			<td><input type="text" class="form-control" value="<%=boardDTO.getBd_title()%>"  name="bd_title" maxlength="50" ></td>
			    		</tr>
			    		<tr>
			    			<td><textarea class="form-control" name="bd_content" maxlength="2048" style= "height:350px" ><%=boardDTO.getBd_content()%></textarea></td>
			    		</tr>
                        <tr>
                            <td colspan="2" style="min-height:200px; text-align:left;">
                            <%
                                // 만약, 첨부파일이 없으면..
                                String fileRoute = boardDTO.getFile_route();
                                if (fileRoute.equals("/file/upload/null") || fileRoute.equals("NULL")) {
                            %>
                                	첨부파일 <input type="file" name="file">
                            <%
                                }
                                else {
                            %>
                                <p style="color: blue; text-decoration: underline;"><%=boardDTO.getFile_name() %></p> <input type="file" name="file" value="파일 변경">
                            <%
                                }
                            %>
                            </td>
                        </tr>
			    	</tbody>
    	    	</table>
    	    	<input type="submit" class="btn btn-primary pull-right" value="수정하기">
    		</form>
        </div>
    </div>
</body>
</html>