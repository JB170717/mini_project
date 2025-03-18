package com.blog.util;

import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class MyBatisConfig {
    
    // 변수명 수정: slqSessionFactory -> sqlSessionFactory
    private static SqlSessionFactory sqlSessionFactory;
    
    // 클래스가 실행될 당시에 단 한번만 동작됨
    static {
        try {
            // 경로는 실제 프로젝트 구조에 맞게 유지
            String resourcePath = "mybatis/config/mybatis-config.xml"; 
            InputStream inputStream = Resources.getResourceAsStream(resourcePath);
            
            sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
            System.out.println("세션팩토리 생성됨");
            
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("세션팩토리 오류");
        }
    }

    // getter 메서드 이름 수정
    public static SqlSessionFactory getSqlSessionFactory() {
        return sqlSessionFactory;
    }

    // getSqlSession 메서드 수정 - 실제 SqlSession 반환하도록
    public static SqlSession getSqlSession() {
        return sqlSessionFactory.openSession();
    }
    
    // SqlSession을 닫기 위한 메서드 추가
    public static void closeSqlSession(SqlSession session) {
        if (session != null) {
            session.close();
        }
    }
}
