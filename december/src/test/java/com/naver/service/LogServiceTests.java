package com.naver.service;

import java.util.Date;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.BeanCurrentlyInCreationException;
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
public class LogServiceTests {

	@Setter(onMethod_ = @Autowired)
	private LogService service;
	
	
	public void testRegister() {
		LogVO log2 = new LogVO();
		log2.setTitle(new Date());
		log2.setBill(null);
		
		log2.setContent("새로 작성하는 내용");
		log2.setWriter("newbie");
		
		service.register(log2);
		log.info(log2);
	}
	
	@Test
	public void testGetList() {
		
		service.getList(new Criteria()).forEach(log2->log.info(log2));
	}
	
	
	public void testGet() {
		LogVO log2 = service.get(2L);
		log.info("내용보기 : "+log2.getContent());
	}
	
	
	public void testUpdate() {
		LogVO log2 = service.get(2L);
		if(log2 == null) {
			return;
		}
		log2.setTitle(new Date());
		log.info(service.modify(log2));
		
	}
	
	
	public void testDelete() {
		log.info(service.remove(2L));
	}
}
