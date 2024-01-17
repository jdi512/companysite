package com.naver.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class TradeDetailVO {
	private Long seq;
	private Long refTno;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date tradeDate;
	private String productCode;
	private String productName;
	private String spec; //스펙
	private Long qty;
	private Long unitPrice;
	private String assortment;
	private String remarks;
	
	public Long getPrice() {
		return this.qty * this.unitPrice;
	}
	
	public Long getTax() {
		return this.qty * this.unitPrice * 10/100;
	}
}
