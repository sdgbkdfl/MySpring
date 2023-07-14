package com.momo.mem;

import org.junit.Test;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class EncodeTest {

	BCryptPasswordEncoder encoder =  new BCryptPasswordEncoder();
	
	@Test
	public void test() {
		String pw ="하이루";
		
		for(int i=0; i<10; i++) {
			// 암호화 할 때마다 새로운 문자열을 반환하며, 복호화 불가
			String encodePw = encoder.encode(pw);
			System.out.println("암호화된 문자열"+encodePw);
			
			//첫번쨰 매개변수는 일치여부 확인하고자 하는 인코딩되지 않는 패스워드
			//두번째 매개변수는 인코딩된 패스워드
			boolean matches = encoder.matches(pw, encodePw);
			System.out.println("인증결과"+matches);
		}
		
		
		String encodePw = encoder.encode(pw); //암호화된 문자(pw)
	}
}
