package com.naver.service;

import java.util.List;

import com.naver.domain.Criteria;
import com.naver.domain.MasterVO;

public interface MasterService {

	public List<MasterVO> getListWithPaging(Criteria cri);
	public Long getTotalCount(Criteria cri);
	public List<MasterVO> getBizItems(int SubCode);
}
