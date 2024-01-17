package com.naver.service;

import java.util.List;

import com.naver.domain.FullCalendarVO;

public interface FullCalendarService {

	public int register(FullCalendarVO[] vo);

	public List<FullCalendarVO> getListPage();

	public FullCalendarVO get(Long dno);

	public int modify(FullCalendarVO vo);

	public int remove(Long dno);

}
