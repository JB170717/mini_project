package com.blog.model;

import java.util.Base64;

public class PostDTO {
    private String postId;    // int → String 변경
    private String content;
    private String userId;    // int → String 변경
    private byte[] thumbnail; // 바이너리 데이터는 그대로 유지
    
    // 기본 생성자
    public PostDTO() {}
    
    public PostDTO(String postId, String content, String userId, byte[] thumbnail ) {
    	super();
    	this.postId = postId;
    	this.content = content;
    	this.userId = userId;
    	this.thumbnail = thumbnail;
    	
    }
    
    
    // 게터와 세터
    public String getPostId() {
        return postId;
    }
    
    public void setPostId(String postId) {
        this.postId = postId;
    }
    
    public String getContent() {
        return content;
    }
    
    public void setContent(String content) {
        this.content = content;
    }
    
    public String getUserId() {
        return userId;
    }
    
    public void setUserId(String userId) {
        this.userId = userId;
    }
    
    public byte[] getThumbnail() {
        return thumbnail;
    }
    
    public void setThumbnail(byte[] thumbnail) {
        this.thumbnail = thumbnail;
    }
    
    @Override
    public String toString() {
        return "PostDTO [postId=" + postId + ", content=" + content 
                + ", userId=" + userId + ", thumbnail=" 
                + (thumbnail != null ? "데이터 있음" : "데이터 없음") + "]";
    }
    
    public String getBase64Image() {
        if (thumbnail != null) {
            return Base64.getEncoder().encodeToString(thumbnail);
        }
        return "";
    }
    
    
    
    
    
    
    
}
