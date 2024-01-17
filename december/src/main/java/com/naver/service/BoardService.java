package com.naver.service;

import java.util.List;

import com.naver.domain.AttachVO;
import com.naver.domain.BoardVO;
import com.naver.domain.Criteria;

public interface BoardService {

	public void register(BoardVO board);
	
	public int registerTmp(BoardVO board);
	
	public BoardVO get(BoardVO board);
	
	public boolean modify(BoardVO board);
	
	public boolean remove(BoardVO board);

	public List<BoardVO> getGallery(Criteria cri);
	
	public List<BoardVO> getList(Criteria cri);
	
	public int getTotal(Criteria cri);

	public List<BoardVO> getTmpList(BoardVO board);

	public void remove(BoardVO[] board);
	
	public List<AttachVO> getAttachList(BoardVO board);
}
