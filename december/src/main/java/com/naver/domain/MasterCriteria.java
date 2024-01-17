package com.naver.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MasterCriteria extends Criteria{

	private Long seq;
	
	private String majorCode;//대분류코드
	private String majorName;//대분류이름
	private Long detailedCode;//세세분류코드
	private String detailedName;//세세분류이름
	
	
	@Override
	public String getListLink() {
		UriComponentsBuilder builder 
				= UriComponentsBuilder.fromPath("")
					.queryParam("pageNum", this.pageNum)
					.queryParam("amount", this.amount)
					.queryParam("majorName", this.majorName)
					.queryParam("majorCode", this.majorCode)
					.queryParam("detailedName", this.detailedName)
					.queryParam("detailedCode", this.detailedCode);
		
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
					.queryParam("detailedName", this.detailedName)
					.queryParam("detailedCode", this.detailedCode)
					.queryParam("seq", this.seq);
		
		return builder.toUriString();
	}
}
