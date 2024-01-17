package com.naver.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import com.naver.domain.MemberCriteria;
import com.naver.domain.MemberVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class MemberMapperTests {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;

	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwencoder;
	
	
	public void testInsert() {
		MemberVO vo = new MemberVO();
		vo.setUserid("admin90");
		vo.setUserpw(pwencoder.encode("1111"));
		vo.setDepartment("경리부");
		vo.setPosition("사장");
		vo.setUserName("홍사장");
		vo.setEmail("admin@aa.com");
		vo.setTel("010-0000-1111");
		
		mapper.insert(vo);
	}
	@Test
	public void testPaging() {
		MemberCriteria cri = new MemberCriteria();
		cri.setPageNum(1);
		cri.setAmount(10);
		
		mapper.getListWithPaging(cri).forEach(member -> log.info(member));
	}
	
	
	
}
