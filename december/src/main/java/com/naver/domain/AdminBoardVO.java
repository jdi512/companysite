package com.naver.domain;

import java.util.Date;
import java.util.Map;

import lombok.Data;

@Data
public class AdminBoardVO {

	private Long bno;
	private String boardId;
	private String boardName;
	private String writer;
	private Date regdate;
	private Date updateDate;
	
}
