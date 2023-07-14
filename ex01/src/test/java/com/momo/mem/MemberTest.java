package com.momo.mem;

import static org.junit.Assert.assertEquals;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.momo.mapper.MemberMapper;
import com.momo.vo.MemberVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j

public class MemberTest {
	
	@Autowired
	MemberMapper memberMapper;
	
	
	public void test() {
		MemberVO member = new MemberVO();
		member.setId("admin");
		member.setPw("1234");
		
		member = memberMapper.login(member);
		log.info(member);
		
	}
	@Test
	public void insertTest() {
		MemberVO member = new MemberVO();
		member.setId("test1");
		member.setPw("1234");
		member.setName("김첨지");
	
		int res = memberMapper.register(member);
		
		assertEquals(1, res);
	}	
	@Test
	public void idCheckTest() {
		MemberVO member = new MemberVO();
		member.setId("test1");
		
		int res = memberMapper.idCheck(member);
		assertEquals(1, res);
	}	
}
