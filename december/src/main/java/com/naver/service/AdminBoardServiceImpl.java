package com.naver.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.naver.domain.AttachVO;
import com.naver.domain.AdminBoardVO;
import com.naver.domain.Criteria;
import com.naver.mapper.AdminBoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class AdminBoardServiceImpl implements AdminBoardService {

	@Setter(onMethod_ = @Autowired)
	private AdminBoardMapper mapper;
	
	@Override
	public void register(AdminBoardVO board) {
				
		mapper.insertSelectKey(board);//게시판등록
		
		mapper.createBoard(board.getBoardId());//게시판생성
		
	}
	

	@Override
	public AdminBoardVO get(Long bno) {
		
		return mapper.read(bno);
	}

	
	@Override
	@Transactional
	public boolean modify(AdminBoardVO board) {
		
		//게시글 수정
		boolean modifyResult = mapper.update(board) == 1;
				
		return modifyResult;
	}

	/**
	 * 게시글 삭제
	 * 첨부파일 게시글 삭제 후 해당 글 삭제
	 */
	@Override
	@Transactional
	public boolean remove(AdminBoardVO board) {
		//테이블 삭제
		mapper.dropTable(board.getBoardId());
		
		//차후 댓글, 첨부파일 삭제
		
		//게시글삭제
		return mapper.delete(board) == 1;
	}

	@Override
	public List<AdminBoardVO> getList(Criteria cri) {
		
		return mapper.getListWithPaging(cri);
	}
	
	@Override
	public List<AdminBoardVO> getGallery(Criteria cri) {
		
		return mapper.getGalleryWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		
		return mapper.getTotalCount(cri);
	}


	@Override
	public int existTable(String tableName) {
		return mapper.existTable(tableName);
	}


	@Override
	public AdminBoardVO getBoardInfo(String boardId) {
		return mapper.getBoardInfo(boardId);
	}

}
