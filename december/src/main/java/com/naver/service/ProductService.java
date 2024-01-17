package com.naver.service;

import java.util.List;

import com.naver.domain.ProductCriteria;
import com.naver.domain.ProductVO;
import com.naver.domain.Criteria;
import com.naver.domain.MasterVO;

public interface ProductService {

	public ProductVO get(String productCode);
	
	public void modify(ProductVO product);

	public List<ProductVO> getList(Criteria cri);

	public long getTotal(Criteria cri);

	public void register(ProductVO product);

	public String getMakePCode();

}
