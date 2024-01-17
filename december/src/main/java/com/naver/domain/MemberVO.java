package com.naver.domain;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberVO {

	private String userid;
	private String userpw;

	private String department;
	private String position;
	
	private String userName;

	private String email;
	private String tel;

	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date regDate;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")	
	private Date updateDate;

	private boolean enabled;
	
	private String pfImg;
		
	private List<AuthVO> authList;
	
}
