package com.naver.service;

import java.util.List;

import com.naver.domain.DiaryVO;

public interface DiaryService {

	public int register(DiaryVO vo);

	public List<DiaryVO> getListPage();

	public DiaryVO get(Long dno);

	public int modify(DiaryVO vo);

	public int remove(Long dno);

}
