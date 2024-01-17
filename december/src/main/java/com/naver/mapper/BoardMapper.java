package com.naver.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import com.naver.domain.BoardVO;
import com.naver.domain.Criteria;
import com.naver.domain.ReplyVO;

public interface BoardMapper {

	public List<BoardVO> getList();
	//등록만 처리
	public void insert(BoardVO board);
	//등록후 pk값을 가져오기
	public void insertSelectKey(BoardVO board);

	public int insertTmp(BoardVO board);
	
	public BoardVO read(BoardVO board);
	
	public int delete(BoardVO board);
	
	public int update(BoardVO board);
	
	public List<BoardVO> getListWithPaging(Criteria cri);

	public List<BoardVO> getGalleryWithPaging(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	
	public List<BoardVO> getTmpList(BoardVO board);
	
	public void updateReplyCnt(@Param("boardId") String boardId, @Param("bno") Long bno, 
								@Param("amount") int amount);
}
