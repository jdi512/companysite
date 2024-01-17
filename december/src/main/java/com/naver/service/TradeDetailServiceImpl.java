package com.naver.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naver.domain.TradeDetailVO;
import com.naver.mapper.TradeDetailMapper;

import lombok.Setter;

@Service
public class TradeDetailServiceImpl implements TradeDetailService{
	
	@Setter(onMethod_ = @Autowired)
	private TradeDetailMapper mapper;

	@Override
	public List<TradeDetailVO> getList(Long tno) {
		// TODO Auto-generated method stub
		return mapper.getList(tno);
	}
	
}
