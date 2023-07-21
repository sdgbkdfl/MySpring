package com.momo.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.momo.mapper.MemberMapper;
import com.momo.vo.MemberVO;


@Service
public class MemberServiceImp implements MemberService   {
	
	@Autowired
	MemberMapper memberMapper;

	@Autowired
	BCryptPasswordEncoder encoder;

	@Override
	public MemberVO login(MemberVO paramMember) {
		
		// 사용자 정보조회
		MemberVO member = memberMapper.login(paramMember);
		if(member != null) {
			// 사용자가 입력한 비밀번호가 일치하는지 확인
			// 사용자가 입력한 비밀번호, 데이터 베이스에 암호화 되어 저장된 비밀번호
			boolean res = encoder.matches(paramMember.getPw(),member.getPw());
			
			// 비밀번호 인증이 성공하면 member객체를 반환
			if(res) {
				// 사용자 권한을 조회
				member.setRole(memberMapper.getMemberRole(member.getId()));
				return member;
	
			}
			
		}
		return null;
		//return memberMapper.login(member);
	}


	@Override
	public int register(MemberVO member) {
		
		// 비밀번호 암호화
//		BCryptPasswordEncoder encoder =  new BCryptPasswordEncoder();
		
		// 암호화된 비번을 다시 비번에 넣어줌
		member.setPw(encoder.encode(member.getPw()));
		
		System.out.println("pw : "+member.getPw());
		return memberMapper.register(member);
	}


	@Override
	public int idCheck(MemberVO member) {
		return memberMapper.idCheck(member);
	}
	

}
