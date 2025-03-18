<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

 <!-- 부트스트랩css파일링크 -->
    <!-- <link rel="stylesheet" href="/프로젝트/css/bootstrap.min.css"> -->

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <!-- 제이쿼리 -->
    <script src="../asset/js/jquery-3.7.1.js"></script>

    <!-- 부트스트랩js파일링크 -->
    <script src="../asset/js/bootstrap.min.js"></script>
    
    <link rel="stylesheet" href="../../css/hashTag.css">

    <style>
        * {
            padding: 0;
            margin: 0;
            box-sizing: border-box;
        }

        body {
            margin: 0 auto;
            
            background-color: #F7F4ED;
        }

		body > div {
			width: 50%;
			margin: 0 auto;
		}
		
		#hashTagHeader {
			.circleBox {
            position: fixed;
            top: 35%;
            left: 16%;
            width: 91px;
        }
		}
		
		
        .contentTitle {
            margin-top: 50px;
            font-size: 120px;
            opacity: 1;
            text-align: left;
        }

        .line {
            margin-bottom: 20px;
        }

        .nicknameAndDate {
            overflow: hidden;
            margin-bottom: 20px;
        }

        .nicknameAndDate > p {
            float: left;
            font-size: 25px;
            text-align: left;
            line-height: 53.98px;
        }

        .nicknameAndDate > button {
            float: right;
            width: 145px;
            height: 54px;
            background: rgba(25,25,25,1);
            opacity: 1;
            border-top-left-radius: 50px;
            border-top-right-radius: 50px;
            border-bottom-left-radius: 50px;
            border-bottom-right-radius: 50px;
            color: rgba(255,253,253,1);
            font-size: 26px;
            text-align: center;
        }

        #contentArea {
            height: 500px; /*글 작성시의 길이로 조정 가능하게 변수지정 해줘야 함*/
            width: 100%;
            border: 1px solid #777; /*임시 공간 확인용*/
            margin-bottom: 20px;
        }

        .tagBox {
            overflow: hidden; /* 도형이 부모 영역을 벗어나지 않도록 설정 */
            margin-bottom: 20px;
        }

        .oneTagString {
            border-top-left-radius: 30px;
            border-top-right-radius: 30px;
            border-bottom-left-radius: 30px;
            border-bottom-right-radius: 30px;
            width: auto;
            background: rgba(217,217,217,1);
            color: rgba(0,0,0,1);
            padding: 0 10px; 
            line-height: 40px;
            font-size: 25px;
            opacity: 1;
            text-align: left;
            white-space: nowrap;
        }

        .commentBox {
            overflow: hidden;
        }

        .commentBox > textarea {
            width: 100%;
            min-height: 100px;
            padding: 15px;
            font-size: 20px;
            margin-bottom: 20px;
            background-color: #F7F4ED;
            border: none;
            outline: none;
            resize: none;
        }

        .commentBox > textarea:focus {
            border-bottom: 1px solid rgba(217,217,217,1);;
            border-top: 1px solid rgba(217,217,217,1);;
        }
        

        .commentBox > input[type="submit"] {
            float: right;
            width: 150px;
            height: 50px;
            background-color:#D7CCC8;
            color:  #666666;
            border-style: none;
            font-size: 20px;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
            border-bottom-left-radius: 10px;
            border-bottom-right-radius: 10px;
        }

        .prevNextContent {
           margin-bottom: 20px;
        }

        .prevNextContent button {
            all: unset;  /* 모든 기본 스타일 제거 */
            cursor: pointer; /* 클릭 시 포인터 커서 표시 */
            font-size: 22px;
            padding: 10px 20px;
            border-top: 2px solid #ccc;
            
            display: block;
            width: 100%;
            height: 60px;
            
        }

        .circleBox {
            position: fixed;
            top: 35%;
            left: 16%;
            width: 91px;
        }

        .circle {
            width: 91px;
            height: 91px;
            background: rgba(217,217,217,1);
            opacity: 1;            
            border-radius: 50%;
            margin-bottom: 20px;
            font-size: 50px;
        }

        .circle > .fa-heart {
            padding: 21px;
            color: red;
        }

        .circle > .fa-star {
            padding: 20px 17.5px;
            color: rgb(253, 253, 65);
        }


    </style>


</head>
<body>

	<header id="hashTagHeader" >

	    <div  class="header">
	      <div class="left">
	        <a href="#" class="logo">
	          <img src="../../img/hashImg/메인 로고.png" alt="로고" />
	        </a>
	      </div>
	
	
	      <div class="right">
	
	        <a href="${pageContext.request.contextPath }/post/Postwritepage.post"  class="writ-icon">
	          <img src="../../img/hashImg/writeIcon.png" alt="글쓰기" />
	        </a>
	        
	        
	
	        <div class="nickname">
	          <button type="button" class="dropdown">닉네임</button>
	          <div class="dropdown-content">
	            <a href="#">로그아웃
	              <hr class="dropdown-hr">
	            </a>
	            <a href="#">내블로그</a>
	            <a href="#">내정보</a>
	          </div>
	        </div>
	
	          <a href="#" class="profile-image">
	            <img src="../../img/hashImg/프로필 이미지(기본).png" allot="프로필이미지(배너)" />
	          </a> 
	          
	        </div>
	    </div>
  	</header>


    <div class="contentTitle">
        <p>제목</p>
    </div>
    <hr class="line">
    <div class="nicknameAndDate">
        <p>닉네임 / 게시글 등록 날짜</p>
        <button type="button">팔로우</button>
    </div>
    <div>
        <div id="contentArea">게시글 내용</div>
        
    </div>
    <div class="tagBox">
           
        <!-- 태그 개수 추가를 위한 js -->
            <script>
                var tagBox = document.querySelector(".tagBox");

                var spacing = 30;

                for(var i = 0; i<3;/*추가하고자 하는 태그 개수 - 나중에 글 작성에서 받아오기*/ i++) { //1개는 강제이기 때문에 1부터 시작작
                    var newTag = document.createElement('span');
                    newTag.classList.add('oneTagString');
                    newTag.style.marginRight =spacing + 'px';
                    newTag.innerHTML = '#' + /*글 작성에서 설정한 태그*/'태그rrrrrrr' ;
                    /* 동일한 태그로 여러개 나올거 같아서 주석 작성해놓음
                    만약 그렇게 되면 value 값 건드리는 식으로 해볼것*/

                    tagBox.appendChild(newTag);

                    console.log();
                }

            </script>
        </div>
    
    <div style="margin-bottom: 20px;">
        <form action="#" class="commentBox"> <!-- 전송해야 하는 링크 확정되면 삽입-->
            <textarea placeholder="댓글을 작성해 주세요"></textarea>
            
            <input type="submit" value="댓글 작성">
        </form>
    </div>

    <div style="width: 50%; height: 200px; margin-bottom: 20px; border: 1px solid #777;">
        누군가 남긴 댓글 영역
    </div>

    <div class="prevNextContent">
        <!-- 단순히 이전글, 다음글로 할지, 해당 글의 제목을 표시 할지 고민 -->
        <button type="button" class="prevContent"><i class="bi bi-chevron-up"></i> 이전 글</button>
        
        <button type="button" class="nextContent"><i class="bi bi-chevron-down"></i> 다음 글</button>

       
    </div>
    
    <div class="circleBox">
        <div class="circle"><i class="fas fa-heart"></i></div>
        <div style="margin-bottom: 20px; text-align: center; font-size:25px  ;">20</div>
        <!-- 좋아요 수 나중에 테이블하고 연동해서 숫자 변경할것 -->
        <div class="circle"><i class="fas fa-star"></i></div>

    </div>

</body>
</html>