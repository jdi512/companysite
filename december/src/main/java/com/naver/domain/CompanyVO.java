package com.naver.domain;

import lombok.Data;

@Data
public class CompanyVO {
	private String taxId;
	private String companyName;
	private String ceoName;
	private String companySeal;
	private String address;
	
	private String tel;
	private String bizType;
	private String bizItem;

}
