package com.naver.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naver.domain.ProductCriteria;
import com.naver.domain.ProductVO;
import com.naver.domain.Criteria;
import com.naver.domain.MasterVO;
import com.naver.mapper.ProductMapper;
import com.naver.mapper.MajorMapper;

import lombok.Setter;

@Service
public class ProductServiceImpl implements ProductService {

	@Setter(onMethod_ = @Autowired)
	private ProductMapper mapper;

	@Setter(onMethod_ = @Autowired)
	private MajorMapper majorMapper;
	
	@Override
	public ProductVO get(String productCode) {
		
		return mapper.get(productCode);
	}


	@Override
	public void modify(ProductVO product) {
		mapper.update(product);
		
	}

	@Override
	public List<ProductVO> getList(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getListWithPaging(cri);
	}

	@Override
	public long getTotal(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getTotalCount(cri);
	}

	@Override
	public void register(ProductVO product) {
		// TODO Auto-generated method stub
		mapper.insert(product);
	}

	@Override
	public String getMakePCode() {
		// TODO Auto-generated method stub
		return mapper.getMakePCode();
	}

}
