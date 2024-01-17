package com.naver.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class FullCalendarVO {

	private Long id;
	private String username;
	private String title;
	
	private String start;
	private String end;
	
	private String backgroundColor;
	
}
