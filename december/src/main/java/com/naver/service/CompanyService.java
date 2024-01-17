package com.naver.service;

import java.util.List;

import com.naver.domain.CompanyCriteria;
import com.naver.domain.CompanyVO;
import com.naver.domain.Criteria;
import com.naver.domain.MasterVO;

public interface CompanyService {

	public CompanyVO get(String companyName);
	
	public CompanyVO getCompanyInfo(String companyName);
	
	public List<MasterVO> getBizType();

	public void modify(CompanyVO company);

	public List<CompanyVO> getList(Criteria cri);

	public long getTotal(Criteria cri);

	public void register(CompanyVO company);

}
