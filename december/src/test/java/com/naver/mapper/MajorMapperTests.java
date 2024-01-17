package com.naver.mapper;



import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.naver.domain.Criteria;
import com.naver.domain.MajorCriteria;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MajorMapperTests {

	@Setter(onMethod_ = @Autowired)
	private MajorMapper mapper;
	
	@Test
	public void testList() {
		MajorCriteria cri = new MajorCriteria();
		cri.setMajorCode("P");
		mapper.getListWithPaging(cri);
	}
	
	public void testTotalCount() {
		Criteria cri = new Criteria();
		mapper.getTotalCount(cri);
	}
	
}
