package com.naver.mapper;



import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.naver.domain.MasterCriteria;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MasterMapperTests {

	@Setter(onMethod_ = @Autowired)
	private MasterMapper mapper;
	
	@Test
	public void testList() {
		MasterCriteria cri = new MasterCriteria();
		cri.setMajorCode("P");
		cri.setDetailedCode(856L);
		mapper.getListWithPaging(cri);
	}
	
	public void testTotalCount() {
		MasterCriteria cri = new MasterCriteria();
		mapper.getTotalCount(cri);
	}
	
}
