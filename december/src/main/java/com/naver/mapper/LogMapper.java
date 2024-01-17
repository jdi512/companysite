package com.naver.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import com.naver.domain.LogVO;
import com.naver.domain.Criteria;

public interface LogMapper {

	//등록후 pk값을 가져오기
	public void insertSelectKey(LogVO log);
	
	public LogVO read(Long bno);
	
	public int delete(Long bno);
	
	public int update(LogVO log);
	
	public List<LogVO> getListWithPaging(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	
}
