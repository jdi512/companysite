package com.naver.domain;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class TradeVO {

	private Long tno;
	private String supplyer;
	private String producter;
	private Long subAmount;
	private Long totalTax;
	private Long finalAmount;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date regdate;
	private boolean receipt;
	
	private List<TradeDetailVO> tradeDetailList;
	
}
