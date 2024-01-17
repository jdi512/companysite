package com.naver.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naver.domain.CompanyCriteria;
import com.naver.domain.CompanyVO;
import com.naver.domain.Criteria;
import com.naver.domain.MasterVO;
import com.naver.mapper.CompanyMapper;
import com.naver.mapper.MajorMapper;

import lombok.Setter;

@Service
public class CompanyServiceImpl implements CompanyService {

	@Setter(onMethod_ = @Autowired)
	private CompanyMapper mapper;

	@Setter(onMethod_ = @Autowired)
	private MajorMapper majorMapper;
	
	@Override
	public CompanyVO get(String companyName) {
		
		return mapper.get(companyName);
	}

	@Override
	public List<MasterVO> getBizType() {
		
		return majorMapper.getBizType();
	}

	@Override
	public void modify(CompanyVO company) {
		mapper.update(company);
		
	}

	@Override
	public List<CompanyVO> getList(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getListWithPaging(cri);
	}

	@Override
	public long getTotal(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getTotalCount(cri);
	}

	@Override
	public void register(CompanyVO company) {
		// TODO Auto-generated method stub
		mapper.insert(company);
	}

	@Override
	public CompanyVO getCompanyInfo(String companyName) {
		// TODO Auto-generated method stub
		return mapper.getCompanyInfo(companyName);
	}

}
