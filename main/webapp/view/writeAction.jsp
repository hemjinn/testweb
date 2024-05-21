<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="board.BoardDAO" %>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="board" class="board.BoardDTO" scope="page"></jsp:useBean>
<jsp:setProperty name="board" property="bd_title"/>
<jsp:setProperty name="board" property="bd_content"/>
<jsp:setProperty name="board" property="file_name"/>
<jsp:setProperty name="board" property="file_realname"/>
<jsp:setProperty name="board" property="file_route"/>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; c harset=UTF-8">
<title>AEGI HACK</title>
</head>
<body>
    <% 
        String AEGIuser = null;
        if (session.getAttribute("AEGIuser") != null) {
            AEGIuser = (String) session.getAttribute("AEGIuser");
        }
        if (AEGIuser == null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
			script.println("alert('로그인 페이지로 이동합니다.')");
            script.println("</script>");
            response.sendRedirect("../index.jsp");
        }
        else {
            // 사용자 명 가져오기
            UserDAO userDao = new UserDAO();
            String userName = userDao.ssName(AEGIuser);

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

            

            if (title == null || content == null){
        		PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('모든 문항을 입력해주세요.')");
                script.println("history.back()");
                script.println("</script>");
        	}
            else {
                BoardDAO boardDAO = new BoardDAO();
                int result = boardDAO.write(title, userName, content, fileName, fileRealName, "/file/upload/"+fileRealName);
                if (result == -1) { // DB오류
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("alert('DB 오류')");
                    script.println("history.back()");
                    script.println("</script>");
                }
                else { // 업로드 성공
                    response.sendRedirect("board.jsp");
                }
            }
        }
    %>
</body>
</html>