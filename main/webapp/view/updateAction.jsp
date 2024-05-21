<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
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

        // 작성자와 접근하려는 사용자 비교
        UserDAO userDao = new UserDAO();
        String userEmail = userDao.ssEmail(boardDTO.getUsername());
        if (!AEGIuser.equals(userEmail)) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('권한이 없습니다.')");
            script.println("</script>");
            response.sendRedirect("board.jsp");
        }
        else {
            // 파일이 업로드 될 경로
            String uploadRoute = "file/upload";
            String uploadDir = this.getClass().getResource("/").getPath().replaceAll("/WEB-INF/classes/", "/");
            uploadDir = uploadDir + uploadRoute;
            out.println("업로드 경로: " + uploadDir);
            // 파일 크기 제한 byte 크기
            int maxSize = 100 * 1024 * 1024;
            
            DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
            
            // Multipartrequest 객체 선언
            MultipartRequest multi = new MultipartRequest(request, uploadDir, maxSize, "UTF-8", policy);
            String fileName = multi.getOriginalFileName("file");
            String fileRealName = multi.getFilesystemName("file");
            String title = multi.getParameter("bd_title");
            String content = multi.getParameter("bd_content");

            if (title == null || content == null | title.equals("") || content.equals("")) {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('모든 문항을 입력해주세요.')");
                script.println("history.back()");
                script.println("</script>");
            }
            else {
                BoardDAO boardDAO = new BoardDAO();
                int result = boardDAO.update(bd_no, title, content, fileName, fileRealName, "/file/upload/"+fileRealName);

                if (result == -1) { // 글 수정 실패 시
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("alert('게시글 수정에 실패하였습니다.')");
                    script.println("history.back()");
                    script.println("</script>");
                }
                else {  // 글 수정 성공 시
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("alert('게시글이 수정되었습니다.')");
                    script.println("</script>");
                    response.sendRedirect("board.jsp");
                }
            }
        }
	%>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="/js/bootstrap.js"></script>
</body>
</html>