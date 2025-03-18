package com.blog.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.blog.service.PostService;
import com.blog.serviceimpl.PostServiceImpl;


@WebServlet("*.post")
public class PostController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public PostController() {
        super();      
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		doAction(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		doAction(request, response);
	}
	
	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//한글처리
		request.setCharacterEncoding("utf-8");
		
		String uri=request.getRequestURI();
		String conPath=request.getContextPath();
		String command = uri.substring(conPath.length());
		
		System.out.println("요청경로:"+command);
		
		PostService service = new PostServiceImpl();
	
		
		if(command.equals("/post/Postwritepage.post")) {
			
			//게시글 작성 페이지로 넘어가기
			request.getRequestDispatcher("/views/post/postWrite.jsp").forward(request, response);
			
			
		}else if(command.equals("/views/post/postForm.post")) { 
			//게시글등록
			
			service.postregist(request, response);
			
		}
		
		
	}
}
