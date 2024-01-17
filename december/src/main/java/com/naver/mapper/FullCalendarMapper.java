package com.naver.mapper;

import java.util.List;

import com.naver.domain.FullCalendarVO;

public interface FullCalendarMapper {

	public int insert(FullCalendarVO vo);

	public List<FullCalendarVO> getListPage();

	public FullCalendarVO read(Long id);

	public int update(FullCalendarVO vo);

	public int delete();

	public void deleteMonth(String startSub);
	
}
