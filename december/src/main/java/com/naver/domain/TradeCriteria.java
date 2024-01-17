package com.naver.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class TradeCriteria extends Criteria{
	
	private Long tno; //일련번호

	
	
	
	@Override
	public String getListLink() {
		UriComponentsBuilder builder 
				= UriComponentsBuilder.fromPath("")
					.queryParam("pageNum", this.pageNum)
					.queryParam("amount", this.amount);
		
		return builder.toUriString();
	}
	
	@Override
	public String getGetLink() {
		UriComponentsBuilder builder 
				= UriComponentsBuilder.fromPath("")
					.queryParam("pageNum", this.pageNum)
					.queryParam("amount", this.amount)
					.queryParam("tno", this.tno);
		
		return builder.toUriString();
	}
}
