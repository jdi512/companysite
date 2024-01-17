package com.naver.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.naver.domain.AttachVO;
import com.naver.domain.AdminBoardVO;
import com.naver.domain.Criteria;

public interface AdminBoardService {

	public void register(AdminBoardVO board);
		
	public AdminBoardVO get(Long bno);
	
	public boolean modify(AdminBoardVO board);
	
	/* public boolean remove(Long bno); */

	public List<AdminBoardVO> getGallery(Criteria cri);
	
	public List<AdminBoardVO> getList(Criteria cri);
	
	public int getTotal(Criteria cri);

	
	public int existTable(@Param("tableName") String tableName);

	public boolean remove(AdminBoardVO board);

	public AdminBoardVO getBoardInfo(String boardId);
	
}
