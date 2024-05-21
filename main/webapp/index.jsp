<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="/css/index.css">
    <title>Playground!!</title>
    <% 
	  if(session.getAttribute("AEGIuser") != null) {
	    response.sendRedirect("view/main.jsp");
	  }
	%>
</head>
<body>
<div class="container right-panel-active">


  <!-- Sign Up -->
  <div class="container__form container--signup">
    <form method="post" action="joinAction.jsp" class="form" id="form1">
      <h2 class="form__title">Sign Up</h2>
      <input type="text" id="username" name="username" placeholder="Username" class="input" required/>
      <input type="email" id="email" name="email" placeholder="Email" class="input" required/>
      <input type="password" id="password" name="password" placeholder="Password" class="input" required/>
      <button type="submit" class="btn">Sign Up</button>
    </form>
  </div>



  <!-- Sign In -->
  <div class="container__form container--signin">
    <form method="post" action="loginAction.jsp" class="form" id="form2">
      <h2 class="form__title">Sign In</h2>
      <input type="email" id="email" name="email" placeholder="Email" class="input" required/>
      <input type="password" id="password" name="password" placeholder="Password" class="input" required/>
      <a onclick="alert('관리자에게 문의해주세요.')" class="link">Forgot your password?</a>
      <button type="submit" class="btn">Sign In</button>
    </form>
  </div>



  <!-- Overlay -->
  <div class="container__overlay">
    <div class="overlay">
      <div class="overlay__panel overlay--left">
        <button class="btn" id="signIn">Sign In</button>
      </div>
      <div class="overlay__panel overlay--right">
        <button class="btn" id="signUp">Sign Up</button>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript" src="/js/index.js"></script>
</body>
</html>