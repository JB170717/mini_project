package com.blog.util;

import java.io.FileInputStream;
import java.io.IOException;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.vertexai.VertexAI;
import com.google.cloud.vertexai.api.GenerateContentResponse;
import com.google.cloud.vertexai.generativeai.GenerativeModel;
import com.google.cloud.vertexai.generativeai.ResponseHandler;

public class GeminiExample {
    public static void main(String[] args) throws IOException{
    	
    	
    	// 메인에서는 실행시 실제로 사용이 잘 되는지 테스트, 아래에서 진짜 메서드 사용가능
    	// 환경 변수 사용
    	GoogleCredentials credentials;
    	String credentialsPath = System.getenv("GOOGLE_APPLICATION_CREDENTIALS");
    	if (credentialsPath != null && !credentialsPath.isEmpty()) {
    	    credentials = GoogleCredentials.fromStream(new FileInputStream(credentialsPath));
    	} else {
    	    // 기본 자격 증명 사용 (관리 서비스 환경에서 유용)
    	    credentials = GoogleCredentials.getApplicationDefault();
    	}
        try {
            // 프로젝트 ID와 위치 설정
        	String projectId = "gen-lang-client-0501126944";
            String location = "us-central1"; // 또는 적절한 리전

            // API 연결 설정
            try (VertexAI vertexAI = new VertexAI(projectId, location)) {
                // 생성 모델 설정
                GenerativeModel model = new GenerativeModel("gemini-2.0-flash", vertexAI);
                
                // 프롬프트 작성
                String prompt = "안녕하세요! 자바 프로그래밍에 대해 간단히 설명해주세요.";
                
                // 응답 생성 요청
                GenerateContentResponse response = model.generateContent(prompt);
                
                // 응답 텍스트 추출
                String result = ResponseHandler.getText(response);
                
                // 결과 출력
                System.out.println("===== 결과 =====");
                System.out.println(result);
                
            } catch (Exception e) {
                System.err.println("API 호출 오류: " + e.getMessage());
                e.printStackTrace();
            }
            
        } catch (Exception e) {
            System.err.println("일반 오류: " + e.getMessage());
            e.printStackTrace();
        }
        
    }
    public String askAi(String ask) {
    	String s = "";
    	String result = "오류가 발생했습니다.";
    	
    	try {
            // 프로젝트 ID와 위치 설정
        	String projectId = "gen-lang-client-0501126944";
            String location = "us-central1"; // 또는 적절한 리전

            // API 연결 설정
            try (VertexAI vertexAI = new VertexAI(projectId, location)) {
                // 생성 모델 설정
                GenerativeModel model = new GenerativeModel("gemini-2.0-flash", vertexAI);
                
                // 프롬프트 작성
                String prompt = ask;
                
                // 응답 생성 요청
                GenerateContentResponse response = model.generateContent(prompt);
                
                // 응답 텍스트 추출
                result = ResponseHandler.getText(response);
                
                // 결과 출력
                System.out.println("===== 결과 =====");
                System.out.println(result);
                
            } catch (Exception e) {
                System.err.println("API 호출 오류: " + e.getMessage());
                e.printStackTrace();
            }
            
        } catch (Exception e) {
            System.err.println("일반 오류: " + e.getMessage());
            e.printStackTrace();
        }
    	
    	
    	
    	
    	
    	return result;
    }
    
    
    	
		

}
