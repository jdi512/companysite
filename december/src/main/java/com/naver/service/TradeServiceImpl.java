package com.naver.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.naver.domain.AttachVO;
import com.naver.domain.CompanyVO;
import com.naver.domain.TradeVO;
import com.naver.domain.Criteria;
import com.naver.domain.ProductVO;
import com.naver.mapper.CompanyMapper;
import com.naver.mapper.ProductMapper;
import com.naver.mapper.TradeDetailMapper;
import com.naver.mapper.TradeMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class TradeServiceImpl implements TradeService {

	@Setter(onMethod_ = @Autowired)
	private TradeMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private TradeDetailMapper tradedetailmapper;
	
	@Setter(onMethod_ = @Autowired)
	private CompanyMapper companymapper;
	
	@Setter(onMethod_ = @Autowired)
	private ProductMapper productmapper;
	
	@Override
	public void register(TradeVO trade) {
				
		mapper.insertSelectKey(trade);//게시판등록
	
		if(trade.getTradeDetailList() == null || trade.getTradeDetailList().size() <=0) {
			return;
		} //빈공간이 있으면 리턴
			
		trade.getTradeDetailList().forEach(tradedetail -> {
			tradedetail.setRefTno(trade.getTno());
			if(!("".equals(tradedetail.getTradeDate()) || "".equals(tradedetail.getProductCode()))) {
				tradedetailmapper.insert(tradedetail);	
			}
			
		});
	}
	

	@Override
	public TradeVO get(Long tno) {
		
		return mapper.read(tno);
	}

	
	@Override
	@Transactional
	public boolean modify(TradeVO trade) {
		
		//게시글 수정
		boolean modifyResult = mapper.update(trade) == 1;
		
		if(trade.getTradeDetailList() == null || trade.getTradeDetailList().size()<=0) {
			return modifyResult;
		}
		//상세내용 삭제
		tradedetailmapper.delete(trade.getTno());
		
		trade.getTradeDetailList().forEach(tradedetail -> {
			tradedetail.setRefTno(trade.getTno());
			if(!("".equals(tradedetail.getTradeDate()) || "".equals(tradedetail.getProductCode()))) {
				tradedetailmapper.insert(tradedetail);	
			}
			
		});
		return modifyResult;
	}

	/**
	 * 게시글 삭제
	 * 첨부파일 게시글 삭제 후 해당 글 삭제
	 */
	@Override
	@Transactional
	public boolean remove(TradeVO trade) {
		
	
		
		//게시글삭제
		return mapper.delete(trade) == 1;
	}

	@Override
	public List<TradeVO> getList(Criteria cri) {
		
		return mapper.getListWithPaging(cri);
	}
	


	@Override
	public int getTotal(Criteria cri) {
		
		return mapper.getTotalCount(cri);
	}


	@Override
	public List<CompanyVO> getCompanyList(String supplyer) {
		// TODO Auto-generated method stub
		return companymapper.getCompanyList(supplyer);
	}


	@Override
	public List<ProductVO> getProductNameList(String productName) {
		// TODO Auto-generated method stub
		return productmapper.getProductNameList(productName);
	}





}
