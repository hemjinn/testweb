<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/css/bootstrap.css"> <!-- 참조  -->
<script type="text/javascript" src="/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
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





    <!-- 게시글 작성 -->
    <div class= "container">
    	<div class= "row">
    		<form method="post" action="writeAction.jsp">
    			<table class= "table table-stripped" style= "text-align: center; boarder: 1px solid #dddddd">
	    	    	<thead>
		    	    	<tr>
		    	    		<th colspan= "2" style= "background-color: #eeeeee; text-align: center;">게시판 글쓰기 양식</th>
		    	    	</tr>
	    	    	</thead>
			    	<tbody>
			    		<tr>
			    			<td><input type="text" class="form-control" placeholder="글 제목"  name="bd_title" maxlength="50" ></td>
			    		</tr>
			    		<tr>
                            <td>
                                <textarea class="form-control" name="bd_content" id="editorTxt" placeholder="내용을 입력해 주세요." style="width: 1000px; height:400px" ></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td><input type="file"></td>
                        </tr>
			    	</tbody>
    	    	</table>
    	    	<input type="submit" class="btn btn-primary pull-right" value="글쓰기">
                <input type="button" class="btn btn-primary pull-right" value="콘솔찍기" onclick="submitPost()">
    		</form>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="/js/bootstrap.js"></script>
    <script type="text/javascript">
        var oEditors = [];
        nhn.husky.EZCreator.createInIFrame({
            oAppRef: oEditors,
            elPlaceHolder: "editorTxt",  //textarea ID 입력
            sSkinURI: "/smarteditor/SmartEditor2Skin.html",  //martEditor2Skin.html 경로 입력
            fCreator: "createSEditor2",
            htParams : { 
                // 툴바 사용 여부 (true:사용/ false:사용하지 않음) 
                bUseToolbar : true, 
                // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음) 
                bUseVerticalResizer : true, 
                // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음) 
                bUseModeChanger : true,
            },
        });

        function submitPost() {
            oEditors.getById["editorTxt"].exec("UPDATE_CONTENTS_FIELD", []);
            let content = document.getElementById("editorTxt").value;

            if(content == '<p>&nbsp;</p>') { //비어있어도 기본 P태그가 붙더라.
                alert("내용을 입력해주세요.");
                ​​​​​​​​oEditors.getById["editorTxt"].exec("FOCUS");
                ​​​​​​​​return;
            }  else {
                ​​​​​​​​console.log(content);
            ​​​​}
        };
    </script>
</body>
</html>