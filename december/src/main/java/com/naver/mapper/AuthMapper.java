package com.naver.mapper;

import java.util.List;

import com.naver.domain.Criteria;
import com.naver.domain.AuthVO;
import com.naver.domain.MemberVO;

public interface AuthMapper {

	public void insert(AuthVO auth);

	public void delete(String userid);
}
