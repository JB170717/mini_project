package com.blog.model;

import java.util.Base64;

public class UserDTO {
    private String email;
    private String password;
    private String gender;
    private String nickname;
    private byte[] profileImage;  // BLOB 데이터를 위한 byte 배열
    private String age;
    private String introduction;
    
    // 기본 생성자
    public UserDTO() {}
    



	




	public UserDTO(String email, String password, String gender, String nickname, byte[] profileImage, String age,
			String introduction) {
		super();
		this.email = email;
		this.password = password;
		this.gender = gender;
		this.nickname = nickname;
		this.profileImage = profileImage;
		this.age = age;
		this.introduction = introduction;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
	}


	public String getGender() {
		return gender;
	}


	public void setGender(String gender) {
		this.gender = gender;
	}


	public String getNickname() {
		return nickname;
	}


	public void setNickname(String nickname) {
		this.nickname = nickname;
	}


	public byte[] getProfileImage() {
		return profileImage;
	}


	public String getIntroduction() {
		return introduction;
	}









	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}









	public void setProfileImage(byte[] profileImage) {
		this.profileImage = profileImage;
	}


	public String getAge() {
		return age;
	}


	public void setAge(String age) {
		this.age = age;
	}


	@Override
    public String toString() {
        return "UserDTO [email=" + email + ", password=" + password + ", gender=" + gender
                + ", nickname=" + nickname + ", profileImage=" + (profileImage != null ? "데이터 있음" : "데이터 없음")
                + ", age=" + age + "]";
    }
    
    public String getBase64Image() {
        if (profileImage != null) {
            return Base64.getEncoder().encodeToString(profileImage);
        }
        return "";
    }
}
