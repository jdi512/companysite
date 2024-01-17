package com.naver.mapper;

import java.util.List;

import com.naver.domain.Criteria;
import com.naver.domain.MasterVO;

public interface MasterMapper {
	
	public List<MasterVO> getListWithPaging(Criteria cri);//리스트
	
	public List<MasterVO> getBizItems(int SubCode);//종목리스트
	
	public Long getTotalCount(Criteria cri);//전체개수
}
