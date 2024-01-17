package com.naver.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.naver.domain.LogVO;
import com.naver.domain.Criteria;
import com.naver.mapper.LogMapper;

import lombok.Setter;

@Service
public class LogServiceImpl implements LogService {

	@Setter(onMethod_ = @Autowired)
	private LogMapper mapper;
	
	@Override
	public void register(LogVO log) {
		
		mapper.insertSelectKey(log);
		
	}
	

	@Override
	public LogVO get(Long bno) {
		
		return mapper.read(bno);
	}

	
	@Override
	public boolean modify(LogVO log) {
		
		//게시글 수정
		boolean modifyResult = mapper.update(log) == 1;
		
		return modifyResult;
	}

	/**
	 * 게시글 삭제
	 * 첨부파일 게시글 삭제 후 해당 글 삭제
	 */
	@Override
	public boolean remove(Long bno) {
		
		//게시글삭제
		return mapper.delete(bno) == 1;
	}

	@Override
	public List<LogVO> getList(Criteria cri) {
		
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		
		return mapper.getTotalCount(cri);
	}

	/**
	 * 목록에서 에이작스로 해당글과 댓글 삭제 
	 * + 해당파일도 삭제 2023.10.23 홍길동
	 */
	@Override
	@Transactional
	public void remove(long[] bnos) {
		for(long bno : bnos) {
			
			mapper.delete(bno);//해당게시글삭제
		}
	}


}
