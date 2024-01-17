package com.naver.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.naver.domain.DiaryVO;
import com.naver.mapper.DiaryMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class DiaryServiceImpl implements DiaryService{

	@Setter(onMethod_ = @Autowired)
	private DiaryMapper mapper;
	
	@Override
	@Transactional
	public int register(DiaryVO vo) {
		
		return mapper.insert(vo);
	}

	@Override
	public List<DiaryVO> getListPage() {
		return mapper.getListPage();
	}

	@Override
	public DiaryVO get(Long dno) {
		return mapper.read(dno);
	}

	@Override
	public int modify(DiaryVO vo) {
		return mapper.update(vo);
	}

	@Override
	public int remove(Long dno) {
		return mapper.delete(dno);
	}


}
