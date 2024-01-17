package com.naver.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naver.domain.Criteria;
import com.naver.domain.MasterVO;
import com.naver.mapper.MasterMapper;

import lombok.Setter;

@Service
public class MasterServiceImpl implements MasterService {
	
	@Setter(onMethod_ = @Autowired)
	private MasterMapper mapper;

	@Override
	public List<MasterVO> getListWithPaging(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getListWithPaging(cri);
	}

	@Override
	public Long getTotalCount(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<MasterVO> getBizItems(int SubCode) {
		// TODO Auto-generated method stub
		return mapper.getBizItems(SubCode);
	}

}
