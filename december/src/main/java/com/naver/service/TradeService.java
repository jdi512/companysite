package com.naver.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.naver.domain.AttachVO;
import com.naver.domain.CompanyVO;
import com.naver.domain.TradeVO;
import com.naver.domain.Criteria;
import com.naver.domain.ProductVO;

public interface TradeService {

	public void register(TradeVO trade);
		
	public TradeVO get(Long tno);
	
	public boolean modify(TradeVO trade);
	

	
	public List<TradeVO> getList(Criteria cri);
	
	public int getTotal(Criteria cri);


	public boolean remove(TradeVO trade);

	public List<CompanyVO> getCompanyList(String supplyer);

	public List<ProductVO> getProductNameList(String productName);

	
	
}
