package com.naver.mapper;

import java.util.List;

import com.naver.domain.ProductCriteria;
import com.naver.domain.ProductVO;
import com.naver.domain.Criteria;

public interface ProductMapper {
	public ProductVO get(String productCode);

	public void update(ProductVO product);

	public List<ProductVO> getListWithPaging(Criteria cri);

	public long getTotalCount(Criteria cri);

	public void insert(ProductVO product);

	public String getMakePCode();

	public List<ProductVO> getProductNameList(String productName);
}
