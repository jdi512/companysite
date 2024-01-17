package com.naver.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import com.naver.domain.DiaryVO;

public interface DiaryMapper {

	public int insert(DiaryVO vo);

	public List<DiaryVO> getListPage();

	public DiaryVO read(Long dno);

	public int update(DiaryVO vo);

	public int delete(Long dno);
	
}
