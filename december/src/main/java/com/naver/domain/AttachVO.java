package com.naver.domain;

import lombok.Data;

@Data
public class AttachVO {

	private String uuid;
	private String uploadPath;
	private String fileName;
	private boolean fileType;

	private String boardId;
	
	private Long bno;
}
