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
	
		if(command.equals("postWrite.post")) {
			request.getRequestDispatcher("postWrite.jsp").forward(request, response);
		}else if(command.equals("/notice/registForm.board")) { 
			//게시글등록
			//service.regist(request, response);
			
		}else if(command.equals("/notice/list.board")) { 
			//게시글목록
			//service.getList(request, response);
			request.getRequestDispatcher("notice_list.jsp").forward(request, response);
		
		}else if(command.equals("/notice/getContent.board")) { 
			//게시글내용조회
			//service.getContent(request, response);
			request.getRequestDispatcher("notice_view.jsp").forward(request, response);
			
		}else if(command.equals("/notice/modify.board")) { 
			//글 수정화면
			//service.getContent(request, response); //글 내용 조회
			request.getRequestDispatcher("notice_modify.jsp").forward(request, response);	
			
		}else if(command.equals("/notice/update.board")) {
			 //글 수정하기
			//service.update(request, response);
			
		}else if(command.equals("/notice/delete.board")) {		
			 //글 삭제	
			//service.delete(request, response);
			
		}else if(command.equals("/view/mainapge")) {
			
			//메인페이지
			service.getmain(request, response);
		}
		
		
	}
}
