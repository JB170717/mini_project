package com.blog.serviceimpl;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.blog.service.PostService;

public class PostServiceImpl implements PostService{

	//게시글 등록
	@Override
	public void postregist(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String postTitle = request.getParameter("postTitle"); 
		String postTag = request.getParameter("postTag");
		String postMain = request.getParameter("postMain");
		String postImage = request.getParameter("postImage");
		
		
		
		
		
		
		
	}

	//게시글등록, 조회, 수정, 삭제
	
	

	
	

}
