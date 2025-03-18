<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>비밀번호 변경</title>
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      margin: 0;
      padding: 0;
      background-color: #F7F4ED;
      color: #191919
    }

    .container {
      max-width: 600px;
      margin: 50px auto;
      padding: 30px;
      background-color: white;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }

    h1 {
      font-size: 24px;
      font-weight: bold;
      margin-bottom: 30px;
      color: #191919;
      text-align: center;
    }

    .form-row {
      margin-bottom: 20px;
    }

    label {
      display: block;
      font-size: 14px;
      color: #555;
      margin-bottom: 8px;
    }

    input[type="password"] {
      width: 100%;
      padding: 12px;
      background-color: white;
      border: 1px solid #ddd;
      border-radius: 4px;
      color: #191919;
      font-size: 16px;
      box-sizing: border-box;
    }

    input[type="password"]:focus {
      border-color: #64CCC5;
      box-shadow: 0 0 0 2px rgba(100, 204, 197, 0.2);
      outline: none;
    }

    .note {
      font-size: 12px;
      color: #777;
      margin-top: 5px;
    }

    .error-message {
      color: #FF5252;
      font-size: 14px;
      margin-top: 5px;
      display: none;
    }

    .button-row {
      display: flex;
      justify-content: space-between;
      margin-top: 30px;
    }

    .submit-btn {
      flex: 1;
      padding: 15px;
      background-color: #191919;
      color: white;
      border: none;
      border-radius: 4px;
      font-size: 16px;
      font-weight: bold;
      cursor: pointer;
    }
    
    .submit-btn:hover {
      background-color: #333333;
    }
    
    .cancel-btn {
      padding: 15px;
      background-color: #f0f0f0;
      color: #333;
      border: none;
      border-radius: 4px;
      font-size: 16px;
      font-weight: bold;
      cursor: pointer;
      margin-right: 10px;
    }
    
    .cancel-btn:hover {
      background-color: #e0e0e0;
    }
    
    .required {
      color: #FF5252;
      margin-left: 3px;
    }
  </style>
</head>
<body>
<script>
  // 메시지가 있으면 알림창 표시 (request 속성 또는 session 속성에서 가져옴)
  // 이렇게 해야지 세션에 있는 메세지도 가져올 수 있음
  var message = "${msg}";
  var sessionMessage = "${sessionScope.msg}";
  
  if(message && message.trim() !== "") {
    alert(message);
  } else if(sessionMessage && sessionMessage.trim() !== "") {
    alert(sessionMessage);
    // 세션에서 메시지 제거 (한 번만 표시하기 위해)
    <% session.removeAttribute("msg"); %>
  }
</script>
<div class="container">
  <h1>비밀번호 변경</h1>
  
  <form id="passwordForm" action="${pageContext.request.contextPath}/users/changePassword.users" method="post">
    <div class="form-row">
      <label for="currentPassword">현재 비밀번호<span class="required">*</span></label>
      <input type="password" id="currentPassword" name="currentPassword" required>
    </div>
    
    <div class="form-row">
      <label for="newPassword">새 비밀번호<span class="required">*</span></label>
      <input type="password" id="newPassword" name="newPassword" required>
    </div>
    
    <div class="form-row">
      <label for="confirmPassword">새 비밀번호 확인<span class="required">*</span></label>
      <input type="password" id="confirmPassword" name="confirmPassword" required>
    </div>
    
    <input type="hidden" name="email" value="${sessionScope.userDTO.email}">
    
    <div class="button-row">
      <button type="button" class="cancel-btn" onclick="history.back()">취소</button>
      <button type="submit" class="submit-btn">비밀번호 변경</button>
    </div>
  </form>
</div>

</body>
</html>
