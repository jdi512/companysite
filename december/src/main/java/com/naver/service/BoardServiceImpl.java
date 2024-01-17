package com.naver.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.naver.domain.AttachVO;
import com.naver.domain.BoardVO;
import com.naver.domain.Criteria;
import com.naver.mapper.AttachMapper;
import com.naver.mapper.BoardMapper;
import com.naver.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class BoardServiceImpl implements BoardService {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;

	@Setter(onMethod_ = @Autowired)
	private ReplyMapper replyMapper;

	@Setter(onMethod_ = @Autowired)
	private AttachMapper attachMapper;
	
	@Override
	@Transactional
	public void register(BoardVO board) {


		mapper.insertSelectKey(board);
		
		if(board.getAttachList() == null || board.getAttachList().size() <= 0) {
			return;
		}
		
		board.getAttachList().forEach(attach -> {
			attach.setBno(board.getBno());
			attach.setBoardId(board.getBoardId());
			attachMapper.insert(attach);
		});
	}
	
	@Override
	public int registerTmp(BoardVO board) {
		
		return mapper.insertTmp(board);
	}

	@Override
	public BoardVO get(BoardVO board) {
		System.out.println(board);
		return mapper.read(board);
	}

	
	@Override
	@Transactional
	public boolean modify(BoardVO board) {
		//첨부파일 글 삭제
		attachMapper.deleteAll(board);
		//게시글 수정
		boolean modifyResult = mapper.update(board) == 1;
		
		//첨부파일이 있으면 추가
		if(modifyResult && board.getAttachList() != null 
				&&	board.getAttachList().size() > 0) {
			
			board.getAttachList().forEach(attach -> {
				attach.setBno(board.getBno());
				attach.setBoardId(board.getBoardId());
				attachMapper.insert(attach);
			});
			
		}
		
		return modifyResult;
	}

	/**
	 * 게시글 삭제
	 * 첨부파일 게시글 삭제 후 해당 글 삭제
	 */
	@Override
	@Transactional
	public boolean remove(BoardVO board) {
		//첨부글삭제
		attachMapper.deleteAll(board);
		//댓글삭제
		replyMapper.deletes(board);
		//게시글삭제
		return mapper.delete(board) == 1;
	}

	@Override
	public List<BoardVO> getList(Criteria cri) {
		
		return mapper.getListWithPaging(cri);
	}
	
	@Override
	public List<BoardVO> getGallery(Criteria cri) {
		
		return mapper.getGalleryWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<BoardVO> getTmpList(BoardVO board) {
		return mapper.getTmpList(board);
	}

	/**
	 * 목록에서 에이작스로 해당글과 댓글 삭제 
	 * + 해당파일도 삭제 2023.10.23 홍길동
	 */
	@Override
	@Transactional
	public void remove(BoardVO[] boards) {
		for(BoardVO board : boards) {
			attachMapper.deleteAll(board);//첨부파일 내용삭제
			replyMapper.deletes(board);//댓글삭제
			mapper.delete(board);//해당게시글삭제
		}
	}

	@Override
	public List<AttachVO> getAttachList(BoardVO board) {
		
		return attachMapper.findByBno(board);
	}


}
