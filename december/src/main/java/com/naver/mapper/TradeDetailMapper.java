package com.naver.mapper;

import java.util.List;

import com.naver.domain.TradeDetailVO;

public interface TradeDetailMapper {
	public void insert(TradeDetailVO tradeDetail);

	public List<TradeDetailVO> getList(Long tno);
	public void delete(Long tno);
}
