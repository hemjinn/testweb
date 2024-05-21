<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardDTO" %>
<% request.setCharacterEncoding("UTF-8"); %>
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
        else {
            BoardDAO boardDAO = new BoardDAO();
            int result = boardDAO.delete(bd_no);

            if (result == -1) { // 글 삭제 실패 시
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('게시글 삭제에 실패하였습니다.')");
                script.println("history.back()");
                script.println("</script>");
            }
            else {  // 글 수정 성공 시
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('게시글이 비활성화되었습니다.')");
                script.println("</script>");
                response.sendRedirect("board.jsp");
            }
        }
	%>
</body>
</html>