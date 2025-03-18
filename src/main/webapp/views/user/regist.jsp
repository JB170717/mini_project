<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<meta charset="UTF-8">
<html>
<head>
  <title>블로그 회원가입</title>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
  <style>
    body {
      background-color: #F7F4ED;
      font-family: 'Noto Sans KR', sans-serif;
      padding: 20px;
    }
    form {
      max-width: 300px;
      margin: 0 auto;
      background-color: white;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
      border: 1px solid #e0d8c9;
    }
    input[type=text], input[type=password] {
      width: 100%;
      padding: 10px;
      margin: 5px 0 10px 0;
      border: 2px solid #000000;
      box-sizing: border-box;
      border-radius: 4px;
    }
    input[type=checkbox] {
      margin-right: 5px;
    }
    .required {
      color: red;
    }
    input[type=submit] {
      background-color: #191919; 
      color: white; 
      padding: 12px; 
      border: none; 
      width: 100%;
      border-radius: 4px;
      font-weight: bold;
      cursor: pointer;
      margin-top: 10px;
    }
    input[type=submit]:hover {
      background-color: #333333;
    }
    h2 {
      color: #3e3e3e;
      margin-bottom: 20px;
    }
    label {
      font-weight: bold;
      color: #555;
    }
    
    /* 모던한 성별 선택 버튼 스타일 */
    .gender-container {
      display: flex;
      gap: 10px;
      margin: 10px 0 20px 0;
    }
    
    .gender-container input[type="radio"] {
      display: none;
    }
    
    .gender-container label {
      flex: 1;
      text-align: center;
      padding: 10px;
      background-color: #f5f5f5;
      border: 1px solid #ddd;
      border-radius: 4px;
      cursor: pointer;
      transition: all 0.3s ease;
      font-weight: normal;
    }
    
    .gender-container input[type="radio"]:checked + label {
      background-color: #191919;
      color: white;
      border-color: #191919;
    }
  </style>
</head>
<body>
<script>
    // 페이지 로드 완료 후 실행
    window.onload = function() {
      var msg = "${msg}"; // 서버에서 전달된 메시지
      if(msg != "") {
        alert(msg); // 메시지가 있으면 팝업으로 표시
      }
    }
</script>
<form action="${pageContext.request.contextPath}/users/registerForm.users" method="post">
  <div style="text-align: center;">
    <img src="${pageContext.request.contextPath}/img/chat-icon.png" alt="블로그 아이콘" width="50">
    <h2>블로그 회원가입</h2>
  </div>

  <label for="email">이메일<span class="required">*</span></label>
  <input type="text" id="email" name="email" placeholder="이메일을 입력해주세요." required>
  
  <label for="password">비밀번호<span class="required">*</span></label>
  <input type="password" id="password" name="password" placeholder="비밀번호를 입력해주세요." required>

  <input type="password" id="password-confirm" name="password-confirm" placeholder="비밀번호를 다시 한번 입력해주세요." required>

  <label for="nickname">닉네임<span class="required">*</span></label>
  <input type="text" id="nickname" name="nickname" placeholder="닉네임을 입력해주세요." required>
  
  <label for="age">나이<span class="required">*</span></label>
  <input type="text" id="age" name="age" placeholder="나이를 입력해주세요." required>

  <p style="font-weight: bold; color: #555; margin-bottom: 5px;">성별<span class="required">*</span></p>
  <div class="gender-container">
    <input type="radio" id="male" name="gender" value="male" required>
    <label for="male">남자</label>
    <input type="radio" id="female" name="gender" value="female">
    <label for="female">여자</label>
  </div>

  <input type="submit" value="가입하기">
</form>
</body>
</html>
