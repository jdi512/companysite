package com.naver.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import com.naver.domain.BoardVO;
import com.naver.domain.Criteria;
import com.naver.domain.ReplyVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	
	public void testGetList() {
		mapper.getList().forEach(board -> log.info(board));
	}
	
	@Test
	public void testPaging() {
		ReplyVO cri = new ReplyVO();
		cri.setBno(6L);
		cri.setBoardId("gallery");
		
		mapper.updateReplyCnt(cri.getBoardId(), cri.getBno(), 1);
	}
	
	
	public void testTotal() {
		Criteria cri = new Criteria();
		cri.setKeyword("11");
		cri.setType("TC");
		log.info(mapper.getTotalCount(cri));
	}
	
	public void testInsert() {
		BoardVO board = new BoardVO();
		board.setTitle("새로 작성하는 글");
		board.setContent("새로 작성하는 내용");
		board.setWriter("newbie");
		
		mapper.insert(board);
		log.info(board);
	}
	
	
	public void testInsertSelectKey() {
		BoardVO board = new BoardVO();
		board.setTitle("새로 작성하는 글 select key");
		board.setContent("새로 작성하는 내용 select key");
		board.setWriter("newbie");
		
		mapper.insertSelectKey(board);
		log.info(board);
	}
	
	
	public void testRead() {
		BoardVO board = new BoardVO();
		board.setBoardId("board");
		board.setBno(2L);
		
		BoardVO res = mapper.read(board);
		log.info(res);
	}
	
	
	public void testDelete() {
		BoardVO board = new BoardVO();
		board.setBoardId("board");
		board.setBno(2L);
		int count = mapper.delete(board);
		log.info("DELETE COUNT : " + count);
	}
	
	public void testUpdate() {
		BoardVO board = new BoardVO();
		board.setTitle("수정된 제목");
		board.setContent("수정된 내용");
		board.setWriter("user00");
		board.setBno(2L);
		
		int count = mapper.update(board);
		log.info("UPDATE COUNT : " + count);
	}
	
}
