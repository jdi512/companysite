package com.naver.service;

import java.util.List;

import com.naver.domain.MemberCriteria;
import com.naver.domain.MemberVO;

public interface MemberService {
	
	public List<MemberVO> getList(MemberCriteria cri);

	public int getTotal(MemberCriteria cri);

	public MemberVO modify(String userid);

	public void register(MemberVO member);

	public MemberVO idDuplicateChk(String userid);

	public boolean modify(MemberVO member);

	public boolean remove(String userid);

	
}
