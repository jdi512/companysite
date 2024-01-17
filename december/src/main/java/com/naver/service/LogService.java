package com.naver.service;

import java.util.List;

import com.naver.domain.LogVO;
import com.naver.domain.Criteria;


public interface LogService {

	public void register(LogVO log);
		
	public LogVO get(Long bno);
	
	public boolean modify(LogVO log);
	
	public boolean remove(Long bno);
	
	public List<LogVO> getList(Criteria cri);
	
	public int getTotal(Criteria cri);

	/*
	 * 목록에서 데이터 삭제
	 */
	public void remove(long[] bnos);
	
}
