package com.naver.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberCriteria extends Criteria{
	
	private String userid;
	
	private String keyUserName;//회원이름 검색
	private String keyDepartment;//주소 검색
	private String keyAuth;//권한 검색
	

	
	@Override
	public String getListLink() {
		UriComponentsBuilder builder 
				= UriComponentsBuilder.fromPath("")
					.queryParam("pageNum", this.pageNum)
					.queryParam("amount", this.amount)
					.queryParam("keyUserName", this.keyUserName)
					.queryParam("keyDepartment", this.keyDepartment)
					.queryParam("keyAuth", this.keyAuth);
		
		return builder.toUriString();
	}
	
	@Override
	public String getGetLink() {
		UriComponentsBuilder builder 
				= UriComponentsBuilder.fromPath("")
					.queryParam("pageNum", this.pageNum)
					.queryParam("amount", this.amount)
					.queryParam("keyUserName", this.keyUserName)
					.queryParam("keyDepartment", this.keyDepartment)
					.queryParam("keyAuth", this.keyAuth)
					.queryParam("userid", this.userid);
		
		return builder.toUriString();
	}

}
