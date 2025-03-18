<%-- src/main/webapp/WEB-INF/views/user/list.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>사용자 목록</title>
    <style>
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 8px; text-align: left; border-bottom: 1px solid #ddd; }
        .profile-img { width: 50px; height: 50px; border-radius: 50%; object-fit: cover; }
    </style>
</head>
<body>
    <h1>사용자 목록</h1>
    
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>프로필</th>
                <th>닉네임</th>
                <th>이메일</th>
                <th>성별</th>
                <th>나이</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="user" items="${users}">
                <tr>
                    <td>${user.userId}</td>
                    <td>
                        <c:if test="${not empty user.profileImage}">
                            <img src="data:image/jpeg;base64,${user.base64Image}" class="profile-img" alt="프로필">
                        </c:if>
                    </td>
                    <td>${user.nickname}</td>
                    <td>${user.email}</td>
                    <td>${user.gender}</td>
                    <td>${user.age}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
