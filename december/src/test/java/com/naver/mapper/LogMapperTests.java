package com.naver.mapper;

import java.util.Date;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import com.naver.domain.LogVO;
import com.naver.domain.Criteria;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class LogMapperTests {

	@Setter(onMethod_ = @Autowired)
	private LogMapper mapper;
	
	@Test
	public void testPaging() {
		Criteria cri = new Criteria();
		cri.setPageNum(1);
		cri.setAmount(20);
//		cri.setKeyword("11");
//		cri.setType("TC");
		mapper.getListWithPaging(cri).forEach(log2 -> log.info(log2));
	}
	
	
	public void testTotal() {
		Criteria cri = new Criteria();
		cri.setKeyword("11");
		cri.setType("TC");
		log.info(mapper.getTotalCount(cri));
	}
	
	
	public void testInsertSelectKey() {
		LogVO log2 = new LogVO();
		log2.setTitle(new Date());
		log2.setContent("새로 작성하는 내용 select key");
		log2.setWriter("newbie");
		
		mapper.insertSelectKey(log2);
		log.info(log2);
	}
	
	
	public void testRead() {
		LogVO log2 = mapper.read(2L);
		log.info(log2);
	}
	
	
	public void testDelete() {
		int count = mapper.delete(1L);
		log.info("DELETE COUNT : " + count);
	}
	
	public void testUpdate() {
		LogVO log2 = new LogVO();
		log2.setTitle(new Date());
		log2.setContent("수정된 내용");
		log2.setWriter("user00");
		log2.setBno(2L);
		
		int count = mapper.update(log2);
		log.info("UPDATE COUNT : " + count);
	}
	
}
