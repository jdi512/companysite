package com.naver.mapper;

import java.util.List;

import com.naver.domain.AttachVO;
import com.naver.domain.BoardVO;

public interface AttachMapper {

	public void insert(AttachVO vo);

	public int delete(String uuid);

	public void deleteAll(BoardVO board);
	
	public List<AttachVO> findByBno(BoardVO board);
	
	public List<AttachVO> getOldFiles();
}
