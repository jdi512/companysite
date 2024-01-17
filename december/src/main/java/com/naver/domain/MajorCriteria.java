package com.naver.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MajorCriteria extends Criteria{

	private Long seq;
	
	private String majorCode;//대분류코드
	private String majorName;//대분류이름
	
	
	@Override
	public String getListLink() {
		UriComponentsBuilder builder 
				= UriComponentsBuilder.fromPath("")
					.queryParam("pageNum", this.pageNum)
					.queryParam("amount", this.amount)
					.queryParam("majorName", this.majorName)
					.queryParam("majorCode", this.majorCode);
		
		return builder.toUriString();
	}
	
	@Override
	public String getGetLink() {
		UriComponentsBuilder builder 
				= UriComponentsBuilder.fromPath("")
					.queryParam("pageNum", this.pageNum)
					.queryParam("amount", this.amount)
					.queryParam("majorName", this.majorName)
					.queryParam("majorCode", this.majorCode)
					.queryParam("seq", this.seq);
		
		return builder.toUriString();
	}
}
