package com.naver.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ReplyPageDTO {

	private int replyCnt;//댓글 수
	private List<ReplyVO> list;//댓글 목록
}
