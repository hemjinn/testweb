<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "user.UserDAO" %>
<%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="user" class="user.User" scope="page"></jsp:useBean>
<jsp:setProperty name="user" property="username"/>
<jsp:setProperty name="user" property="email"/>
<jsp:setProperty name="user" property="password"/>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; c harset=UTF-8">
<title>회원가입</title>
</head>
<body>
	<% 
		String AEGIuser = null;
		if(session.getAttribute("AEGIuser") != null) {
			AEGIuser = (String)session.getAttribute("AEGIuser");
		}

		if(AEGIuser != null) {
			PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('이미 로그인되었습니다.')");
            script.println("</script>");
            response.sendRedirect("view/main.jsp");	// 메인 페이지로 이동
		}

		if(user.getUsername() == null || user.getEmail() == null || user.getPassword() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('모든 문항을 입력해주세요.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else {
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user);
			if (result == -1) { // 회원가입 실패시
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 이메일입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else { // 회원가입 성공시
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('회원가입 성공')");
                script.println("</script>");
                response.sendRedirect("view/index.jsp");    // 메인 페이지로 이동
			}
		}
	%>
</body>
</html>