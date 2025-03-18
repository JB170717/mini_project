package com.blog.serviceimpl;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.tomcat.util.http.fileupload.ByteArrayOutputStream;
import org.json.JSONObject;

import com.blog.dao.UserDAO;
import com.blog.model.UserDTO;
import com.blog.model.UserMapper;
import com.blog.service.UserService;
import com.blog.util.MyBatisConfig;

public class UserServiceImpl implements UserService {
	
	private SqlSessionFactory sqlSessionFactory = MyBatisConfig.getSqlSessionFactory();

    @Override
    public void register(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	
        // isDup 메서드 -> dao 메서드에서 끌어옴.
    	
    	String email = request.getParameter("email");
    	String pw = request.getParameter("password");
    	String pwConfirm = request.getParameter("password-confirm");
    	String nickname = request.getParameter("nickname");
    	String age = request.getParameter("age");
    	String gender = request.getParameter("gender");
    	String introduction = nickname + "의 블로그입니다."; //기본 자기소개문 세팅
    	
    	UserDAO dao = UserDAO.getInstance();
    	SqlSession sql = null;
    	UserMapper user = null;
    	
    	
    	try {
    		if (dao.isDuplicate(email)) { //중복이면 true -> 실패케이스
    			request.setAttribute("msg", "중복된 이메일입니다.");
    			request.getRequestDispatcher("/views/user/regist.jsp").forward(request, response);
    			return;
    			
    		}else if (!pw.equals(pwConfirm)) { //받아온 비밀번호 두개가 서로 일치하지 않는 케이스
    			request.setAttribute("msg", "비밀번호가 동일하지 않습니다.");
    			request.getRequestDispatcher("/views/user/regist.jsp").forward(request, response);
    			return;
				
			}else { //중복 아니니까 성공케이스
    			UserDTO dto = new UserDTO(email, pw, gender, nickname, null, age, introduction);
    			
    			sql = sqlSessionFactory.openSession(true);
    			user = (UserMapper)sql.getMapper(UserMapper.class);
    			
    			int result = user.regist(dto);
    			
    			System.out.println("결과값은 성공시 1 반환" + result);
    			
    			String contextPath = request.getContextPath();
    			response.sendRedirect(contextPath + "/users/loginForm.users");
    			return;
    		}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(sql != null) {  // null 체크 추가
		        MyBatisConfig.closeSqlSession(sql);
		    }
		}
    }

    @Override
    public void login(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
    	String email = request.getParameter("email");
    	String pw = request.getParameter("password");
    	
    	Map<String, String> params = new HashMap<>();
    	params.put("email", email);
    	params.put("password", pw);
    	
    	SqlSession sql = null;
    	UserMapper user = null;
    	
    	
    	try {
    		sql = sqlSessionFactory.openSession(true);
    		user = (UserMapper)sql.getMapper(UserMapper.class);
    		UserDTO dto = user.login(params);
    		
    		if (dto == null) { //로그인 실패
        		System.out.println("로그인 실패");
        		request.setAttribute("msg", "아이디, 비밀번호를 확인하세요");
    			request.getRequestDispatcher("/views/user/login.jsp").forward(request, response);
    			
    		}else { // 성공 - 세션 넣어주기
    			System.out.println("로그인 성공");
    			HttpSession session= request.getSession();
    			session.setAttribute("userDTO", dto);
    			
    			// 수정 후 (절대 경로 사용)
    			response.sendRedirect(request.getContextPath() + "/views/mainpage/mainpage.jsp");
    		}
    		
    		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(sql != null) {  // null 체크 추가
		        MyBatisConfig.closeSqlSession(sql);
		    }
		}
    	
    }

    @Override
    public void getAllUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("■■■ UserServiceImpl의 getAllUsers() 메서드 시작 ■■■");
        
        SqlSession sqlSession = null;
        
        try {
            System.out.println("→ SqlSession 객체 생성 시도");
            sqlSession = sqlSessionFactory.openSession();
            
            if (sqlSession == null) {
                System.out.println("❌ SqlSession 객체가 null입니다!");
                request.setAttribute("errorMessage", "데이터베이스 연결에 실패했습니다.");
                return;
            }
            System.out.println("✓ SqlSession 객체 생성 성공");
            
            System.out.println("→ 'UserMapper.getAllUsers' 쿼리 실행 시도");
            List<UserDTO> users = sqlSession.selectList("UserMapper.getAllUsers");
            System.out.println("✓ 쿼리 실행 완료");
            
            // 결과 처리
            if (users == null) {
                System.out.println("❌ 조회 결과가 null입니다!");
                request.setAttribute("errorMessage", "사용자 목록을 불러올 수 없습니다.");
            } else if (users.isEmpty()) {
                System.out.println("❗ 조회 결과가 비어있습니다 (데이터 없음)");
                request.setAttribute("users", users);
            } else {
                System.out.println("✓ 총 " + users.size() + "개의 사용자 데이터를 조회했습니다");
                if (!users.isEmpty()) {
                    UserDTO firstUser = users.get(0);
                    System.out.println("  [첫 번째 사용자 정보]"); 
                    System.out.println("  - email: " + firstUser.getEmail());
                    System.out.println("  - nickname: " + firstUser.getNickname());
                }
                request.setAttribute("users", users);
                System.out.println("✓ request에 사용자 목록 속성 추가 완료");
            }
            
        } catch (Exception e) {
            System.out.println("❌❌❌ 예외 발생: " + e.getClass().getName());
            System.out.println("❌❌❌ 예외 메시지: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "사용자 목록을 불러오는 중 오류가 발생했습니다: " + e.getMessage());
        } finally {
            System.out.println("→ SqlSession 종료 시도");
            try {
                MyBatisConfig.closeSqlSession(sqlSession);
                System.out.println("✓ SqlSession 정상 종료");
            } catch (Exception e) {
                System.out.println("❌ SqlSession 종료 중 오류 발생: " + e.getMessage());
            }
        }
        
        System.out.println("■■■ UserServiceImpl의 getAllUsers() 메서드 종료 ■■■");
    }

    @Override
    public void getProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        
    }

    @Override
    public void updateProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 파라미터 가져오기
        String email = request.getParameter("email");
        String nickname = request.getParameter("name");
        String bio = request.getParameter("bio");
        
        // null 값 처리 - bio가 null이면 빈 문자열로 대체
        if (bio == null) {
            bio = "";
        }
        
        Map<String, String> params = new HashMap<>();
        params.put("email", email);
        params.put("nickname", nickname);
        params.put("bio", bio);
        SqlSession sql = null;
        
        try {
            sql = sqlSessionFactory.openSession(true);
            UserMapper userMapper = sql.getMapper(UserMapper.class);
            
            // 업데이트 수행
            Integer result = userMapper.updateProfile(params);
            
            if (result != null && result > 0) {
                System.out.println("정보 변경 성공");
                
                // DB에서 최신 사용자 정보 조회
                UserDTO updatedUser = userMapper.getUserByEmail(email);
                
                // 세션에 저장된 사용자 정보 업데이트
                HttpSession session = request.getSession();
                session.setAttribute("userDTO", updatedUser);
                
                // 마이페이지로 리다이렉트
                
                response.sendRedirect(request.getContextPath() + "/views/mainpage/mainpage.jsp");
            } else {
                System.out.println("정보 변경 실패");
                response.sendRedirect(request.getContextPath() + "/mypage?error=update");
            }
        } catch (Exception e) {
            System.out.println("프로필 업데이트 오류: " + e.getMessage());
        } finally {
        	MyBatisConfig.closeSqlSession(sql);
        }
    }


    @Override
    public void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        
        SqlSession sql = null;
        
        try {
            sql = sqlSessionFactory.openSession(true);
            UserMapper userMapper = sql.getMapper(UserMapper.class);
            
            // 아이디 삭제
            int result = userMapper.deleteUser(email);
            
            if (result > 0) {
                System.out.println("아이디 삭제 성공");
                
                //세션 삭제 (꼭 필요함)
                
                HttpSession session = request.getSession(false); 
                if (session != null) {
                    session.invalidate();
                    System.out.println("세션 삭제 완료");
                }
                
                response.sendRedirect(request.getContextPath() + "/views/mainpage/index.jsp");
            } else {
                System.out.println("아이디 삭제 실패");
            }
        } catch (Exception e) {
            System.out.println("아이디 삭제 오류: " + e.getMessage());
        } finally {
        	if (sql != null) {
                MyBatisConfig.closeSqlSession(sql);
        	}
        }
        
    }

    @Override
    public void updateProfilePic(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
    	
    	SqlSession sqlSession = sqlSessionFactory.openSession(true);
    	
    	System.out.println("사진업뎃테스트");
        
        // JSON 응답 설정
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        JSONObject jsonResponse = new JSONObject();
        
        try {
            // 세션에서 사용자 정보 가져오기
            HttpSession session = request.getSession();
            UserDTO user = (UserDTO) session.getAttribute("userDTO");
            
            if (user == null) {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "로그인이 필요합니다.");
                out.print(jsonResponse.toString());
                return;
            }
            
            // 멀티파트 요청 처리
            Part filePart = request.getPart("profileImage");
            if (filePart == null || filePart.getSize() == 0) {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "이미지 파일이 없습니다.");
                out.print(jsonResponse.toString());
                return;
            }
            
            // 파일을 바이트 배열로 변환
            InputStream inputStream = filePart.getInputStream();
            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            byte[] buffer = new byte[4096];
            int bytesRead = -1;
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
            byte[] imageBytes = outputStream.toByteArray();
            inputStream.close();
            outputStream.close();
            
            // 이미지 크기 검증
            if (imageBytes.length > 1024 * 1024 * 2) { // 2MB 제한
                jsonResponse.put("success", false);
                jsonResponse.put("message", "이미지 크기가 너무 큽니다. 2MB 이하로 업로드해주세요.");
                out.print(jsonResponse.toString());
                return;
            }
            
            // MyBatis 매퍼 인터페이스 사용
            UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
            
            // 사용자 정보 업데이트
            user.setProfileImage(imageBytes);
            
            // 매퍼에 전달
            int result = userMapper.updateProfileImage(user);
            
            if (result > 0) {
                // 세션 정보 업데이트
                session.setAttribute("userDTO", user);
                
                // Base64로 인코딩된 이미지 문자열 반환
                String base64Image = user.getBase64Image();
                
                jsonResponse.put("success", true);
                jsonResponse.put("imagePath", "data:image/jpeg;base64," + base64Image);
            } else {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "프로필 이미지 업데이트에 실패했습니다.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.put("success", false);
            jsonResponse.put("message", "서버 오류: " + e.getMessage());
        }finally {
        	if(sqlSession != null) {
                MyBatisConfig.closeSqlSession(sqlSession);
            }
		}
        
        out.print(jsonResponse.toString());
    }

	@Override
	public void changePassword(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String email = request.getParameter("email");
		String currentPassword = request.getParameter("currentPassword");
		String newPassword = request.getParameter("newPassword");
		String confirmPassword = request.getParameter("confirmPassword");
		
		// 디버깅을 위한 로그 출력
		System.out.println("===== 비밀번호 변경 디버깅 정보 =====");
		System.out.println("요청 파라미터:");
		System.out.println("- 이메일: " + email);
		System.out.println("- 현재 비밀번호: " + currentPassword);
		System.out.println("- 새 비밀번호: " + newPassword);
		System.out.println("- 확인 비밀번호: " + confirmPassword);
		
		
		
		
		SqlSession sql = null;
		
		try {
			sql = sqlSessionFactory.openSession(true);
            UserMapper userMapper = sql.getMapper(UserMapper.class);
            UserDTO userdto = userMapper.getUserByEmail(email);
            
         // UserDTO에서 가져온 저장된 비밀번호
    		String storedPassword = userdto.getPassword();
    		System.out.println("- DB에 저장된 비밀번호: " + storedPassword);
            
            if (!userdto.getPassword().equals(currentPassword)) { // 현재 비번 입력이 틀렸을때
				System.out.println("비밀번호 변경 오류 - 현재 비밀번호 틀렸음");
				request.setAttribute("msg", "현재 비밀번호가 일치하지 않습니다.");
				request.getRequestDispatcher("/views/user/changePassword.jsp").forward(request, response);
				return;
				
			}else if (!newPassword.equals(confirmPassword)) { // 비번 동일하지 않을때
				System.out.println("비밀번호 변경 오류 - 비밀번호가 동일하지 않습니다.");
				request.setAttribute("msg", "비밀번호가 동일하지 않습니다.");
				request.getRequestDispatcher("/views/user/changePassword.jsp").forward(request, response);
				return;
				
			}else { //성공 케이스 - 이제는 비밀번호 변경 해줘야함
				int result = userMapper.changePassword(new HashMap<String, String>() {{
		            put("email", email);
		            put("password", newPassword);
		        }});
				
				if (result > 0) { //쿼리문 실행 성공시
					System.out.println("비밀번호 변경 성공");
					request.setAttribute("msg", "비밀번호 변경에 성공했습니다.");
					response.sendRedirect(request.getContextPath() + "/views/mainpage/mainpage.jsp");
					return;
					
				}else { //쿼리문 실패
					System.out.println("비밀번호 변경 실패");
					request.setAttribute("msg", "비밀번호 변경에 실패했습니다.");
					request.getRequestDispatcher("/views/user/changePassword.jsp").forward(request, response);
				}
			}
            
            
            
            
		} catch (Exception e) {
			System.out.println("비밀번호 변경 오류: " + e.getMessage());
			
		} finally {
			if (sql != null) {
                MyBatisConfig.closeSqlSession(sql);
        	}
		}
		
	}

}

