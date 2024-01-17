package com.naver.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardVO {
	
	private String boardId;	
	
	private Long bno;
	private String title;
	private String content;
	private String writer;
	private Date regdate;
	private Date updateDate;
	
	private int replyCnt;

	private int attachCnt;
	
	private String thumb;
	
	private List<AttachVO> attachList;
}
