var email = document.querySelector(".email");
var emailok = document.getElementById("email-ok");
var pswcon = document.getElementById("password-container");
var password = document.querySelector(".password");
var pswok = document.getElementById("psw-ok");
var iderror = document.querySelector(".id-error");
var pswerror = document.querySelector(".psw-error");

emailok.onclick = function() {

    if (false) {  // 실제로 이메일 체크하는 로직 필요
        email.style.display = "none";
        emailok.style.display = "none";
        
        
        // 비밀번호 입력창을 부드럽게 표시
        pswcon.classList.add("show");
        password.focus();
    } else {
        iderror.style.display = 'block';
    }

    
    
    
}

pswok.onclick = function() {

    
}