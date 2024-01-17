package com.naver.service;

import java.util.List;

import com.naver.domain.TradeDetailVO;

public interface TradeDetailService {

	public List<TradeDetailVO> getList(Long tno);

}
