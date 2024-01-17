package com.naver.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.naver.domain.MemberCriteria;
import com.naver.mapper.AuthMapper;
import com.naver.mapper.MemberMapper;
import com.naver.domain.AuthVO;
import com.naver.domain.MemberVO;

import lombok.Setter;

@Service
public class MemberServiceImpl implements MemberService {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;

	@Setter(onMethod_ = @Autowired)
	private AuthMapper authMapper;

	@Override
	public List<MemberVO> getList(MemberCriteria cri) {

		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(MemberCriteria cri) {

		return mapper.getTotalCount(cri);
	}

	@Override
	public MemberVO modify(String userid) {

		return mapper.read(userid);
	}

	@Override
	public void register(MemberVO member) {

		mapper.insert(member);

		for (AuthVO auth : member.getAuthList()) {
			authMapper.insert(auth);
		}
	}

	@Override
	public MemberVO idDuplicateChk(String userid) {

		return mapper.read(userid);
	}

	@Override
	public boolean modify(MemberVO member) {
		
		int result = mapper.update(member);

		authMapper.delete(member.getUserid());
		
		for (AuthVO auth : member.getAuthList()) {
			authMapper.insert(auth);
		}
		return result == 1;
	}

	@Transactional
	@Override
	public boolean remove(String userid) {
		
		authMapper.delete(userid);
		
		return mapper.delete(userid) == 1;
	}

}
