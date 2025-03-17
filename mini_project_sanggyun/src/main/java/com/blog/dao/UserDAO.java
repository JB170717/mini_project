package com.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;

import com.blog.model.UserDTO;
import com.blog.util.JdbcUtil;
import com.blog.util.MyBatisConfig;

public class UserDAO {
	/*
	 * DAO는 클래스는 여러개 만들필요 없이, 객체가 한개만 생성되도록
	 * singleton클래스로 생성
	 */
	//1. 나자신의 객체를 1개 생성한다.
	private static UserDAO instance = new UserDAO();
	//2. 외부에서 생성자를 호출할수 없도록 private막는다
	private UserDAO() {
		
		try {
			InitialContext context = new InitialContext();
			dataSource = (DataSource)context.lookup("java:comp/env/jdbc/oracle");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	//3. 외부에서 객체를 요구할 때, instance를 반환합니다.
	public static UserDAO getInstance() {
		return instance;
	}
	////////////////////////////////////////////////////////////////////
	//커넥션풀을 사용할 dataSource클래스
    
    private DataSource dataSource;
    
    public boolean isDuplicate(String email) { // 중복체크 메서드, 중복일시 true, 중복 아닐시에는 false 리턴
    	
    	int result = 0;
    	
    		Connection conn = null;
    		PreparedStatement pstmt = null;
    		ResultSet rs = null;
    		
    		String sql = "SELECT * FROM USERS WHERE EMAIL = ?";
    		
    		try {
    			conn = dataSource.getConnection();
    			pstmt = conn.prepareStatement(sql);
    			pstmt.setString(1, email);
    			
    			rs = pstmt.executeQuery(); //
    			
    			if(rs.next()) {
    				result = 1; //중복의 의미
    			} else {
    				result = 0;
    			}
    			
    		} catch (Exception e) {
    			e.printStackTrace();
    		} finally {
    			JdbcUtil.close(conn, pstmt, rs);
    		}
    		
    	if (result == 1) {
			return true;
		}else {
			return false;
		}
    }
    

}
