<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AEGI HACK</title>
</head>
<body>
<%
	session.removeAttribute("AEGIuser");
	response.sendRedirect("../index.jsp");
%>
</body>
</html>