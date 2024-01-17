package com.naver.mapper;

import java.util.List;

import com.naver.domain.CompanyCriteria;
import com.naver.domain.CompanyVO;
import com.naver.domain.Criteria;

public interface CompanyMapper {
	public CompanyVO get(String companyName);
	
	public CompanyVO getCompanyInfo(String companyName); 

	public void update(CompanyVO company);

	public List<CompanyVO> getListWithPaging(Criteria cri);

	public long getTotalCount(Criteria cri);

	public void insert(CompanyVO company);

	public List<CompanyVO> getCompanyList(String supplyer);
}
