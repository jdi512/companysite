package com.naver.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import org.springframework.web.util.UriComponentsBuilder;



@Getter
@Setter
@ToString
public class ProductCriteria extends Criteria{
	
	private String productCode;
	private String productName;
	private String Manufacturer;
	
	
	
	@Override
	public String getListLink() {
		UriComponentsBuilder builder 
				= UriComponentsBuilder.fromPath("")
					.queryParam("pageNum", this.pageNum)
					.queryParam("amount", this.amount)
					.queryParam("productCode", this.productCode)
					.queryParam("productName", this.productName);
		
		return builder.toUriString();
	}
	
	@Override
	public String getGetLink() {
		UriComponentsBuilder builder 
				= UriComponentsBuilder.fromPath("")
					.queryParam("pageNum", this.pageNum)
					.queryParam("amount", this.amount)
					.queryParam("productCode", this.productCode)
					.queryParam("productName", this.productName)
					.queryParam("Manufacturer", this.Manufacturer);
		
		return builder.toUriString();
	}
}
