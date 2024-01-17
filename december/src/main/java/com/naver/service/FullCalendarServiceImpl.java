package com.naver.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.naver.domain.FullCalendarVO;
import com.naver.mapper.FullCalendarMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class FullCalendarServiceImpl implements FullCalendarService{

	@Setter(onMethod_ = @Autowired)
	private FullCalendarMapper mapper;
	
	@Override
	@Transactional
	public int register(FullCalendarVO[] vo) {
		//기존 내용전부삭제후
		//2023-12-12T16:29:00+09:00 ===> 2023-12 변경
		mapper.delete();
		
		//다시 등록.
		int res = 0;
		for(int i = 0; i < vo.length; i++) {
			res = mapper.insert(vo[i]);
		}
		return res;
	}

	@Override
	public List<FullCalendarVO> getListPage() {
		return mapper.getListPage();
	}

	@Override
	public FullCalendarVO get(Long dno) {
		return mapper.read(dno);
	}

	@Override
	public int modify(FullCalendarVO vo) {
		return mapper.update(vo);
	}

	@Override
	public int remove(Long dno) {
		return mapper.delete();
	}


}
