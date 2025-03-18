<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<link href="${pageContext.request.contextPath }/css/postWrite.css" rel="stylesheet" />

    <!-- 부트스트랩css파일링크 -->
    <!-- <link rel="stylesheet" href="/프로젝트/css/bootstrap.min.css"> -->

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <!-- 제이쿼리 -->
    <script src="../mainpage/asset/js/jquery-3.7.1.js"></script>

    <!-- 부트스트랩js파일링크 -->
    <script src="../mainpage/asset/js/bootstrap.min.js"></script>

	
</head>
<body>
    
    <!-- <div class="bodytext_area box_inner"> -->
        <!-- appForm -->
        <!-- <form action="registForm.board" class="appForm" method="post">
            <fieldset>
                <legend>상담문의 입력 양식</legend>
                <p class="info_pilsoo pilsoo_item">필수입력</p>
                <ul class="app_list">
                    <li class="clear">
                        <label for="email_lbl" class="tit_lbl pilsoo_item">등록일</label>
                        <div class="app_content email_area">
                            <input type="text" id="datepicker_a" placeholder="날짜를 선택하세요" name="regdate" class="hasDatepicker"><p></p>
                        </div>
                    </li>
                    
                    <li class="clear">
                        <label for="email_lbl" class="tit_lbl pilsoo_item">작성자</label>
                        <div class="app_content email_area">
                            <input type="hidden">
                            <input type="text" placeholder="작성자" value="qwer@naver.com" name="email" required="" readonly="">

                        </div>
                    </li>
                    <li class="clear">
                        <label for="name_lbl" class="tit_lbl pilsoo_item">제목</label>
                        <div class="app_content"><input type="text" class="w100p" id="name_lbl" placeholder="제목을 입력하세요" name="title" required=""></div>
                    </li>


                    <li class="clear">
                        <label for="content_lbl" class="tit_lbl">문의내용</label>
                        <div class="app_content"><textarea id="content_lbl" class="w100p" placeholder="간단한 상담 요청 사항을 남겨주시면 보다 상세한 상담이 가능합니다.
전화 상담 희망시 기재 부탁드립니다." name="content"></textarea></div>
                    </li>
                </ul>
                <p class="btn_line"> -->
                    <!-- 
                    <a href="javascript:;" class="btn_baseColor">글작성</a>
                    <a href="javascript:;" class="btn_baseColor">목록</a>
                     -->
                     <!-- <input type="submit" class="btn_baseColor" value="문의하기">
                     <button type="button" class="btn_baseColor">글목록</button>
                </p>	
            </fieldset>
        </form> -->
        <!-- //appForm -->
        
    <!-- </div>

    <div class="sc-bXTejn jKrbgT">
        <div class="sc-ctqQKy ekNSVs">java</div>
        <div class="sc-ctqQKy ekNSVs">css</div>
        <input placeholder="태그를 입력하세요" tabindex="2" class="sc-eGRUor khIrO" value="">
        <div class="sc-gsNilK kiwVjm"></div>
    </div> -->

<form action="postForm.post" method="post">
    <div class="createContentTitle">
        
            <textarea name="postTitle" placeholder="제목을 입력하세요" required></textarea>
        
        <hr>
    </div>
    


    <div class="createTagBox" >
        
            <textarea name="postTag" id="createTag" placeholder="태그를 작성해주세요" value=""></textarea>
        
        <ul class="registeredTag">
        </ul>
    </div>

    <script>
        var createTag = document.getElementById("createTag")
        var registeredTag = document.querySelector(".registeredTag")
        
        /*엔터 치면 태그 들어감감*/
        createTag.addEventListener("keydown", function(event) {
            if(event.key === 'Enter') { /*마우스가 클릭 된 상태에서 엔터를 누름*/
                event.preventDefault();
                var newTagLi = document.createElement("li");
                
                newTagLi.innerHTML = createTag.value;
                registeredTag.appendChild(newTagLi)
                createTag.value = "";

            }
        } )

        /*들어간 태그 클릭하면 태그 삭제됨*/
        registeredTag.addEventListener("click", function(event2) {
            if(event2.target.tagName != "LI") {
                return;
            } else {
            console.log(event2.target);

            event2.target.remove();
            }
        })



    </script>

    <div class="contentWrite">
        <div id="contentWriteBox">
        	
        	<textarea id="contentWriteMain" name="postMain">본문 내용작성</textarea>
        	
        </div>
    </div>

    <div class="imagePlus">
        <div>
            첨부파일
        </div>
        
        <ul>
            <li class="imagePlusButton"><div><i class="bi bi-file-earmark-plus"></i>파일 첨부하기</div></li>

			<input type="file" id="postfile-upload" name="postImage" accept="image/*" style="display:none;">

            <script> 
            	/*x버튼 누르면 li 삭제하는 js*/
                var deleteButton = document.querySelector(".imagePlus > ul");

                deleteButton.addEventListener("click", function() {
                    if(event.target.classList.contains("deleteButton")) {
                        event.target.closest("li").remove();

                    }

                } )

                /*첨부파일 버튼 누르면 파일첨부 열리는 js*/
                var addButton = document.querySelector(".imagePlus > ul > .imagePlusButton > div")
                var imagePlus = document.querySelector(".imagePlus > ul");
                var fileInput = document.getElementById("postfile-upload");
				var contentWriteBox = document.getElementById("contentWriteBox") //본문 내용 입력칸
                var contentWriteMain = document.getElementById("contentWriteMain"); //기존 텍스트 영역
				
                addButton.addEventListener("click", function() {
                	fileInput.click();
                })
                
                
                fileInput.addEventListener("change", function() {
					var file = fileInput.files[0];
                	
                	if(file) {

            		// 파일을 Base64로 변환
                    var reader = new FileReader();
                    reader.onload = function(event) {
	                    var base64Image = event.target.result; // Base64로 변환된 이미지 데이터
						
	                    console.log(base64Image);
	                    
	                    // 기존 텍스트 영역의 내용 가져오기
	                    var currentText = contentWriteMain.value;
	                    
	                    // 본문 내용 작성 칸에 이미지 삽입
	                    var imageTag = `<img src="${base64Image}" alt="첨부된 이미지" style="max-width: 100%; margin-top: 10px;">`;
	
	                    // 기존 본문 내용에 이미지 태그 추가
	                    contentWriteBox.innerHTML += `
	                        <textarea id="contentWriteMain" placeholder="내용작성">${currentText}</textarea>
	                        <div>${imageTag}</div>
	                        <div>${fileNameTag}</div> <!-- 파일 이름 추가 -->
	                    `; 
	                    	
	                    // 기존 textarea의 값을 다시 설정 (텍스트를 유지하기 위해)
                		contentWriteMain = document.getElementById("contentWriteMain");	                    
	                    
	
	                    /*li로 올리기*/
	                    var newImageLi = document.createElement("li");
	                    var newDeleteButton = document.createElement("button");
	
	                    newDeleteButton.innerHTML = "X";
	                    newDeleteButton.classList.add("deleteButton");
	
	                    //파일 이름만 리스트에 표시
	                    newImageLi.innerHTML = file.name; //파일 이름을 표시
	
	                    // 새로운 요소들을 ul에 추가
	                    var listOfPlusImage = imagePlus.querySelectorAll("li"); //배열
	                    // 파일 첨부하기 버튼을 제외한 나머지 li 항목들만 포함되게 합니다.
	                    var lastListItem = listOfPlusImage[listOfPlusImage.length - 1];
	                    // 마지막 item은 파일 첨부 버튼이므로 그 전 항목을 찾습니다. //배열에서 인덱스 이용해서 특정 값 찾기기
	                    
	                    // 새 항목을 기존 항목과 기존 항목 앞에 추가
	                    imagePlus.insertBefore(newImageLi, lastListItem);  // 마지막 항목 앞에 추가
	
	                    /*x버튼 추가*/
	                    newImageLi.appendChild(newDeleteButton);
                		}
                    reader.readAsDataURL(file);  // 파일을 Base64로 읽기
                	}
                });

            </script>
            
           
            <!-- <script> /*x버튼 누르면 li 삭제하는 js*/
                var deleteButton = document.querySelector(".imagePlus > ul");

                deleteButton.addEventListener("click", function() {
                    if(event.target.classList.contains("deleteButton")) {
                        event.target.closest("li").remove();

                    }

                } )

                /*첨부파일 버튼 누르면 파일첨부 열리는 js*/
                var addButton = document.querySelector(".imagePlus > ul > .imagePlusButton > div")
                var imagePlus = document.querySelector(".imagePlus > ul");
                

                addButton.addEventListener("click", function() {

                    /*첨부파일 넣는거*/

                    /*li로 올리기*/
                    var newImageLi = document.createElement("li");
                    var newDeleteButton = document.createElement("button");

                    newImageLi.innerHTML = "1111"; //사진 추가 기능 넣으면 그 사진의 이름으로 대체
                    newDeleteButton.innerHTML = "X"
                    newDeleteButton.classList.add("deleteButton")

                    /*첨부파일 앞에 li 추가*/

                    // 새로운 요소들을 ul에 추가
                    var listOfPlusImage = imagePlus.querySelectorAll("li"); //배열
                    // 파일 첨부하기 버튼을 제외한 나머지 li 항목들만 포함되게 합니다.
                    var beforeLastList = listOfPlusImage[listOfPlusImage.length - 2];
                    // 마지막 item은 파일 첨부 버튼이므로 그 전 항목을 찾습니다. //배열에서 인덱스 이용해서 특정 값 찾기기
                    
                    // 새 항목을 기존 항목과 기존 항목 앞에 추가
                    imagePlus.insertBefore(newImageLi, beforeLastList);  // 마지막 항목 앞에 추가




                    /*x버튼 추가*/
                    newImageLi.appendChild(newDeleteButton);
                    
                    

                })

            </script> -->
            
            
            
            
            
            

        </ul>
    </div>


    <footer>
        <div>
            <div class="footerBox">
                <button type="button"><i class="bi bi-arrow-left"></i> 나가기</button>

                <input type="submit" value="등록">
            </div>
        </div>
    </footer>
</form>
    








</body>
</html>