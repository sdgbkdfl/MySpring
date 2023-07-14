package com.momo.mem;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.momo.service.MemberService;
import com.momo.vo.MemberVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class memberServiceTest {
	
	@Autowired
	MemberService memberService;
	
	// 테스트가 통과한다면 로그인 기능이 정상적으로 작동
	@Test
	public void test() {
		// 객체 생성
		MemberVO member = new MemberVO();
		
		// 아이디 비밀번호 설정
		member.setId("test3");
		member.setPw("1234");
		
		// memberService의 login 메서드 호출하여 로그인 시도
		member = memberService.login(member);
		
		log.info(member);
		
		// 주어진 값이 null이 아니라면 테스트를 통과하고, null이라면 테스트가 실패
		assertNotNull(member);
	}
	
	// memberService.register() 메서드가 올바르게 동작하여 
	// 회원 가입이 성공하고, 반환된 결과가 1임을 확인하는 역할
	@Test
	public void registerTest() {
		MemberVO member = new MemberVO();
		
		// 아이디 비밀번호 설정
		member.setId("test3");
		member.setPw("1234");
		member.setName("name3");
		
		int res = memberService.register(member);
		
		// res 변수가 1과 일치하는지 확인
		assertEquals(1, res);
	}

	@Test
	public void testIdCheck() {
		MemberVO member = new MemberVO();
		member.setId("test2");
		
		int res = memberService.idCheck(member);		
		System.out.println("결과 : "+ res);
		
	}
}
