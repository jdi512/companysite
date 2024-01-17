package com.naver.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class LogVO {

	private Long bno;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date title;
	private String content;
	private String etc;
	private String bill;
	private String writer;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date regdate;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date updateDate;
	
}
