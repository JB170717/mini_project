<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>로그인</title>
  <style>
    body {
      background-color: #f5f5f0;
      font-family: sans-serif;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }

    .container {
      width: 500px;
      padding: 20px;
    }

    .blog-title {
      color: #aaa;
      font-size: 14px;
      text-align: left;
      margin-bottom: 15px;
    }

    .login-content {
      display: flex;
      gap: 20px; /* 요소 사이 간격 줄임 */
    }

    .icon-section {
      flex: 1;
    }

    .form-section {
      flex: 1.2;
    }

    .chat-icon {
      width: 100px;
      margin-bottom: 10px;
    }

    h1 {
      margin: 0;
      font-size: 20px;
    }

    input {
      width: 100%;
      padding: 10px;
      margin-bottom: 10px; /* 간격 줄임 */
      border: 1px solid #ddd;
      border-radius: 0;
      background-color: white;
      box-sizing: border-box;
    }

    .login-btn {
      background-color: #111;
      color: white;
      border: none;
      padding: 10px 20px;
      cursor: pointer;
      margin-top: 5px;
    }
  </style>
</head>
<body>
<div class="container">
<script>
    // 페이지 로드 완료 후 실행
    window.onload = function() {
      var msg = "${msg}"; // 서버에서 전달된 메시지
      if(msg != "") {
        alert(msg); // 메시지가 있으면 팝업으로 표시
      }
    }
  </script>
  <div class="blog-title">fluent-md2-blog</div>

  <div class="login-content">
    <div class="icon-section">
      <img src="${pageContext.request.contextPath}/img/chat-icon.png" alt="채팅 아이콘" class="chat-icon">
      <h1>환영합니다!</h1>
    </div>

    <div class="form-section">
      <form action="${pageContext.request.contextPath}/users/login.users" method="post">
        <input type="email" name="email" placeholder="이메일을 입력하세요." required>
        <input type="password" name="password" placeholder="비밀번호를 입력하세요" required>
        <button type="submit" class="login-btn">로그인</button>
      </form>
    </div>
  </div>
</div>
</body>
</html>
