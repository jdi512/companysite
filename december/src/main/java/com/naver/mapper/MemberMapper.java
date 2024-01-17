package com.naver.mapper;

import java.util.List;

import com.naver.domain.MemberCriteria;
import com.naver.domain.AuthVO;
import com.naver.domain.MemberVO;

public interface MemberMapper {

	public MemberVO read(String userid);
	
	public List<MemberVO> getListWithPaging(MemberCriteria cri);

	public int getTotalCount(MemberCriteria cri);

	public void insert(MemberVO member);

	public int update(MemberVO member);

	public int delete(String userid);

}
