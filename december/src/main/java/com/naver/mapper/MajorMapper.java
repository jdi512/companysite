package com.naver.mapper;

import java.util.List;

import com.naver.domain.Criteria;
import com.naver.domain.MasterVO;

public interface MajorMapper {
	
	public List<MasterVO> getListWithPaging(Criteria cri);//리스트

	public List<MasterVO> getBizType();//업태(업종 유형)목록
	
	public Long getTotalCount(Criteria cri);//전체개수
}
