package com.naver.domain;

import lombok.Data;

@Data
public class ProductVO {
	 private String productCode;
	 private String productName;
	 private String productImg;
	 private String manufacturer;//제조업체
	 private String spec; //스펙
	 
	 private Long unitPrice;
}
