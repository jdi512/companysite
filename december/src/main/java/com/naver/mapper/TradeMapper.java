package com.naver.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import com.naver.domain.TradeVO;
import com.naver.domain.CompanyVO;
import com.naver.domain.Criteria;

public interface TradeMapper {
	 
	
	public List<TradeVO> getList();
	//등록만 처리
	public void insert(TradeVO trade);
	//등록후 pk값을 가져오기
	public void insertSelectKey(TradeVO trade);
	
	public TradeVO read(Long tno);
	
	public int delete(TradeVO trade);
	
	public int update(TradeVO trade);
	
	public List<TradeVO> getListWithPaging(Criteria cri);

	public int getTotalCount(Criteria cri);
	
	
}
