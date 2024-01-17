package com.naver.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naver.domain.Criteria;
import com.naver.domain.MasterVO;
import com.naver.mapper.MajorMapper;

import lombok.Setter;

@Service
public class MajorServiceImpl implements MajorService {
	
	@Setter(onMethod_ = @Autowired)
	private MajorMapper mapper;

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

}
