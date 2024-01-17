package com.naver.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.naver.domain.AdminBoardVO;
import com.naver.domain.Criteria;

public interface AdminBoardMapper {
	 
	
	public List<AdminBoardVO> getList();
	//등록만 처리
	public void insert(AdminBoardVO board);
	//등록후 pk값을 가져오기
	public void insertSelectKey(AdminBoardVO board);
	
	public AdminBoardVO read(Long bno);
	
	public int delete(AdminBoardVO board);
	
	public int update(AdminBoardVO board);
	
	public List<AdminBoardVO> getListWithPaging(Criteria cri);

	public List<AdminBoardVO> getGalleryWithPaging(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	
	public void createBoard(String tableName);
	
	public int existTable(@Param("tableName") String tableName);	
	
	public void dropTable(String tableName);
	
	public AdminBoardVO getBoardInfo(String boardId);
}
