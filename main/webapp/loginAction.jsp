<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "user.UserDAO"%>
<%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="user" class="user.User" scope="page"></jsp:useBean>
<jsp:setProperty name="user" property="email"></jsp:setProperty>
<jsp:setProperty name="user" property="password"></jsp:setProperty>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; c harset=UTF-8">
<title>로그인</title>
</head>
<body>
	<% // 자바 코드 삽입
        String AEGIuser = null;
        if (session.getAttribute("AEGIuser") != null) {
            AEGIuser = (String)session.getAttribute("AEGIuser");
        }


        if (AEGIuser != null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('이미 로그인되었습니다.')");
            script.println("location.href = 'view/main.jsp'");    // 메인 페이지로 이동
            script.println("</script>");
        }


        UserDAO userDAO = new UserDAO();
        int result = userDAO.login(user.getEmail(), user.getPassword());
        if (result == 1) {
            AEGIuser = user.getEmail();
            session.setAttribute("AEGIuser", AEGIuser); // 로그인 시 세션 생성
            response.sendRedirect("view/main.jsp");
        }
        else if (result == 0 || result == -1){
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('로그인에 실패하였습니다.')");
            script.println("history.back()");   //이전 페이지로 사용자를 보냄
            script.println("</script>");
        }
        else if (result == -2){
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('DB 오류가 발생했습니다.')");
            script.println("history.back()");    //이전 페이지로 사용자를 보냄
            script.println("</script>");
        }
	%>
</body>
</html>