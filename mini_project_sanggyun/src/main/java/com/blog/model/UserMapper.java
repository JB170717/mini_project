package com.blog.model;

import java.util.ArrayList;
import java.util.Map;

public interface UserMapper {

	//	//메서드 선언 - 메서드명 xml구현체가 동일한 이름으로 사용함 
	String getTime();
	//마이바티스의 매개변수는 기본이 1개(DTO,MAP)타입을 사용합니다.
	int regist(UserDTO dto);
	UserDTO login(Map<String, String> params);
	public int updateProfileImage(UserDTO user);
	Integer updateProfile(Map<String, String> params); // int는 null을 못받아서 인티져로 받음
	UserDTO getUserByEmail(String email);
	int deleteUser(String email);
	int changePassword(Map<String, String> params);

	
}
