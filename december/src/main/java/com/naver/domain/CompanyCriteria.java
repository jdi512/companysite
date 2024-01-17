package com.naver.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CompanyCriteria extends Criteria{
	
	private String companyName;

	private String majorCode;
	private String majorName;
	private String detailedCode;
	private String detailedName;
	
	
	
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
					.queryParam("companyName", this.companyName);
		
		return builder.toUriString();
	}
}