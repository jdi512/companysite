package com.naver.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.naver.domain.BoardVO;
import com.naver.domain.Criteria;
import com.naver.domain.ReplyPageDTO;
import com.naver.domain.ReplyVO;
import com.naver.mapper.AdminBoardMapper;
import com.naver.mapper.BoardMapper;
import com.naver.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyServiceImpl implements ReplyService{

	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;

	@Setter(onMethod_ = @Autowired)
	private BoardMapper boardMapper;
	
	@Override
	@Transactional
	public int register(ReplyVO vo) {
		
		boardMapper.updateReplyCnt(vo.getBoardId(), vo.getBno(), 1);
		return mapper.insert(vo);
	}

	@Override
	public ReplyVO get(Long rno) {
		
		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyVO vo) {
		
		return mapper.update(vo);
	}

	@Override
	@Transactional
	public int remove(Long rno) {
		
		ReplyVO vo = mapper.read(rno);		
		
		boardMapper.updateReplyCnt(vo.getBoardId(), vo.getBno(), -1);
		
		return mapper.delete(rno);
	}

	@Override
	public int removes(BoardVO board) {
		return mapper.deletes(board);
	}
	
	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		
		return mapper.getListWithPaging(cri, bno);
	}

	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {
		
		return new ReplyPageDTO(
				mapper.getCountByBno(bno), 
				mapper.getListWithPaging(cri, bno));
	}


}
