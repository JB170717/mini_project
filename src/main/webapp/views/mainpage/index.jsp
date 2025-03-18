<%-- src/main/webapp/index.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>메인 페이지</title>
</head>
<body>
    <h1>블로그 홈페이지</h1>
    
    <ul>
        <li><a href="${pageContext.request.contextPath}/posts">게시글 목록</a></li>
        <li><a href="${pageContext.request.contextPath}/users/list.users">사용자 목록</a></li>
        <li><a href="${pageContext.request.contextPath}/users/loginForm.users">로그인</a></li>
        <li><a href="${pageContext.request.contextPath}/views/user/regist.jsp">회원가입</a></li>
        <li><a href="${pageContext.request.contextPath}/views/mainpage/geminitestpage.jsp">제미니테스트</a></li>
        
        <li><a href="${pageContext.request.contextPath }/post/Postwritepage.post">글쓰기</a></li>
	         
        
    </ul>
</body>
</html>
	