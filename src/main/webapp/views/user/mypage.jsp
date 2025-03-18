<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>프로필 관리</title>
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
      margin: 0 auto;
      padding: 20px;
    }

    .profile-section {
      display: flex;
      align-items: center;
      margin-bottom: 30px;
      padding-bottom: 20px;
      border-bottom: 1px solid #ddd;
    }

    .profile-image {
      width: 120px;
      height: 120px;
      border-radius: 50%;
      background-color: #e5e5e5;
      margin-right: 20px;
      position: relative;
      overflow: hidden;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .profile-image img {
	  width: 100%;
	  height: 100%;
	  object-fit: cover; /* 이미지에 적용해야 함 */
	}

    .edit-icon {
      position: absolute;
      bottom: 5px;
      right: 5px;
      background-color: #191919;
      width: 30px;
      height: 30px;
      border-radius: 50%;
      display: flex;
      justify-content: center;
      align-items: center;
      cursor: pointer;
      border: 2px solid white;
      color: white;
    }

    .profile-info {
      flex-grow: 1;
    }
    .section {
      margin-bottom: 25px;
      padding-bottom: 20px;
      border-bottom: 1px solid #ddd;
    }

    .section-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 15px;
    }

    .section-title {
      font-size: 16px;
      font-weight: bold;
      margin: 0;
    }

    .form-row {
      margin-bottom: 15px;
    }

    label {
      display: block;
      font-size: 14px;
      color: #555;
      margin-bottom: 8px;
    }

    input[type="text"],
    input[type="email"],
    input[type="password"],
    textarea {
      width: 100%;
      padding: 12px;
      background-color: white;
      border: 1px solid #ddd;
      border-radius: 4px;
      color: #191919;
      font-size: 16px;
      box-sizing: border-box;
    }

    input[type="text"]::placeholder,
    input[type="email"]::placeholder,
    textarea::placeholder {
      color: #999;
    }

    .note {
      font-size: 12px;
      color: #777;
      margin-top: 5px;
    }

    .submit-btn {
      width: 100%;
      padding: 15px;
      background-color: #191919;
      color: white;
      border: none;
      border-radius: 4px;
      font-size: 16px;
      font-weight: bold;
      cursor: pointer;
      margin-top: 20px;
    }
    
    .submit-btn:hover {
      background-color: #333333;
    }
    
    input[type=submit]:hover {
      background-color: #333333;
    }

    .withdrawal-link {
      display: block;
      text-align: right;
      color: #666;
      text-decoration: none;
      margin-top: 15px;
      font-size: 14px;
    }

    .required {
      color: #FF5252;
      margin-left: 3px;
    }
    input[type="email"][readonly],
    input[readonly] {
      background-color: #f0f0f0;
      color: #666;
      border: 1px solid #ddd;
      cursor: not-allowed;
    }
    textarea#bio {
      font-family: 'Noto Sans KR', sans-serif;
      line-height: 1.5;
      font-size: 15px;
      letter-spacing: -0.3px;
      padding: 12px 15px;
      border-radius: 6px;
      transition: all 0.2s ease;
    }

    textarea#bio:focus {
      border-color: #64CCC5;
      box-shadow: 0 0 0 2px rgba(100, 204, 197, 0.2);
    }
    
    .password-link {
      display: inline-block;
      padding: 10px 15px;
      background-color: #191919;
      color: white;
      text-decoration: none;
      border-radius: 4px;
      font-size: 14px;
      border: 1px solid #191919;
      transition: all 0.2s ease;
    }
    
    .password-link:hover {
      background-color: #333333;
    }

  </style>
</head>
<body>
<div class="container">
  <div class="profile-section">
    <div class="profile-image">
      <img id="profile-preview" src="${empty sessionScope.userDTO.base64Image ? 'user-icon.png' : 'data:image/jpeg;base64,'.concat(sessionScope.userDTO.base64Image)}" alt="프로필 이미지">
      <label for="profile-upload" class="edit-icon">✏️</label>
      <input type="file" id="profile-upload" name="profileImage" accept="image/*" style="display:none;">
    </div>
    <div class="profile-info">
      <h1>${sessionScope.userDTO.nickname}</h1>
    </div>
  </div>
  
  <script>
document.addEventListener('DOMContentLoaded', function() {
  const fileInput = document.getElementById('profile-upload');
  const previewImg = document.getElementById('profile-preview');
  
  fileInput.addEventListener('change', function() {
    if (fileInput.files && fileInput.files[0]) {
      const reader = new FileReader();
      reader.onload = function(e) {
        previewImg.src = e.target.result;
      }
      reader.readAsDataURL(fileInput.files[0]);
      
      uploadImage(fileInput.files[0]);
    }
  });
  
//컨텍스트 경로 가져오기
  const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf('/',1));

  function uploadImage(file) {
    console.log("파일 업로드 시작:", file.name, file.size);
    const formData = new FormData();
    formData.append('profileImage', file);
    
    // 컨텍스트 경로를 포함한 URL로 요청
    fetch(contextPath + '/users/updateProfilePic.users', {
      method: 'POST',
      body: formData
    })
    .then(response => {
      console.log("서버 응답 상태:", response.status);
      return response.json();
    })
    .then(data => {
      console.log("서버 응답 데이터:", data);
      if(data.success) {
        alert('프로필 이미지가 성공적으로 업로드되었습니다!');
      } else {
        alert('이미지 업로드 실패: ' + data.message);
      }
    })
    .catch(error => {
      console.error('Error:', error);
      alert('이미지 업로드 중 오류가 발생했습니다.');
    });
  }
});
</script>

</body>

  <form action="${pageContext.request.contextPath}/users/updateProfile.users" method="post">
    <!-- 1. 기본 정보 (첫번째) -->
    <div class="section">
      <div class="section-header">
        <h2 class="section-title">기본 정보</h2>
      </div>
      <div class="form-row">
        <label for="name">닉네임<span class="required">*</span></label>
        <input type="text" id="name" name="name" value="${sessionScope.userDTO.nickname}" required>
      </div>

    <!-- 2. 이메일 (두번째) -->
    <div class="section">
      <div class="section-header">
        <h2 class="section-title">이메일 주소</h2>
      </div>
      <div class="form-row">
        <input type="email" id="email" name="email" value="${sessionScope.userDTO.email}" readonly >
      </div>
    </div>

    <!-- 3. 자기소개 (세번째) -->
    <div class="section">
      <div class="section-header">
        <h2 class="section-title">자기소개</h2>
      </div>
      <div class="form-row">
        <textarea id="bio" name="bio" rows="3" placeholder="자기소개를 입력해주세요">${sessionScope.userDTO.introduction}</textarea>
        <p class="note">포스트 및 블로그에서 보여지는 프로필에 공개되는 정보입니다.</p>
      </div>
    </div>

    <!-- 4. 비밀번호 변경 (네번째) - 링크로 변경됨 -->
    <div class="section">
      <div class="section-header">
        <h2 class="section-title">비밀번호</h2>
      </div>
      <div class="form-row">
        <a href="${pageContext.request.contextPath}/views/user/changePassword.jsp" class="password-link">비밀번호 변경하기 ></a>
        <p class="note">비밀번호를 변경하려면 위 링크를 클릭하세요.</p>
      </div>
    </div>

    <button type="submit" class="submit-btn">회원정보 수정</button>
    <a href="#" onclick="confirmDelete('${sessionScope.userDTO.email}'); return false;" class="withdrawal-link">회원탈퇴 ></a>

	<script>
		function confirmDelete(email) {
		    if(confirm('정말로 탈퇴하시겠습니까?')) {
		        location.href = '${pageContext.request.contextPath}/users/delete.users?email=' + email;
		    }
		}
	</script>
    
  </form>
</div>
</body>
</html>

</html>