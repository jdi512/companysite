package com.naver.service;

import java.util.List;

import com.naver.domain.BoardVO;
import com.naver.domain.Criteria;
import com.naver.domain.ReplyPageDTO;
import com.naver.domain.ReplyVO;

public interface ReplyService {

	public int register(ReplyVO vo);

	public ReplyVO get(Long rno);

	public int modify(ReplyVO vo);
	
	public int remove(Long rno);
	
	public int removes(BoardVO board);

	public List<ReplyVO> getList(Criteria cri, Long bno);
	
	public ReplyPageDTO getListPage(Criteria cri, Long bno);
}
