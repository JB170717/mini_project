package com.blog.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.blog.service.UserService;
import com.blog.serviceimpl.UserServiceImpl;

@WebServlet("*.users")
@MultipartConfig(
	    fileSizeThreshold = 1024 * 1024,     // 1MB
	    maxFileSize = 1024 * 1024 * 10,      // 10MB
	    maxRequestSize = 1024 * 1024 * 15    // 15MB
	)
public class UserController extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    
    public UserController() {
        super();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doAction(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doAction(request, response);
    }
    
    protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 한글처리
        request.setCharacterEncoding("utf-8");
        
        String uri = request.getRequestURI();
        String conPath = request.getContextPath();
        String command = uri.substring(conPath.length());
        
        System.out.println("요청경로:" + command);
        
        // 사용할 서비스 선언
        UserService service = new UserServiceImpl();
        
        // 요청 경로에 따른 처리
        if(command.equals("/users/register.users")) {
            // 회원가입 페이지로 이동
            request.getRequestDispatcher("/WEB-INF/views/user/register.jsp").forward(request, response);
            
        } else if(command.equals("/users/registerForm.users")) {
            // 회원가입 처리
            service.register(request, response);
            
        } else if(command.equals("/users/login.users")) {
            // 로그인 처리
            service.login(request, response);
            
        } else if(command.equals("/users/loginForm.users")) {
            // 로그인 폼 페이지로 포워딩
            request.getRequestDispatcher("/views/user/login.jsp").forward(request, response);
         
        } else if(command.equals("/users/list.users")) {
            // 사용자 목록 조회
            service.getAllUsers(request, response);
            request.getRequestDispatcher("/user/list.jsp").forward(request, response);
            
        } else if(command.equals("/users/profile.users")) {
            // 프로필 조회
            service.getProfile(request, response);
            request.getRequestDispatcher("/WEB-INF/views/user/profile.jsp").forward(request, response);
            
        } else if(command.equals("/users/editProfile.users")) {
            // 프로필 수정 페이지로 이동
            service.getProfile(request, response);
            request.getRequestDispatcher("/WEB-INF/views/user/edit.jsp").forward(request, response);
            
        } else if(command.equals("/users/updateProfile.users")) {
            // 프로필 수정 처리
            service.updateProfile(request, response);
            
        } else if(command.equals("/users/updateProfilePic.users")) {
            // 프로필 수정 처리
        	System.out.println("컨트롤 업데이트 프로파일 픽 실행");
            service.updateProfilePic(request, response);
            
        } else if(command.equals("/users/logout.users")) {
            // 로그아웃 처리
            HttpSession session = request.getSession();
            session.invalidate();
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            
        } else if(command.equals("/users/delete.users")) {
            // 회원 탈퇴 처리
        	System.out.println("탈퇴 왔나요?");
            service.deleteUser(request, response);
        } else if(command.equals("/views/mainpage/mainpage.users")) {
        	// 메인페이지 
        	//service.getmain(request, response);
        	
        } else if (command.equals("/users/changePassword.users")) {
            service.changePassword(request, response);
            return; // 메서드 내부에서 리다이렉트
        }
    }
}
