package com.momo.service;


import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.momo.vo.MemberVO;


@Service
public interface MemberService {

	MemberVO login(MemberVO member);

	public int register(MemberVO member);

	public int idCheck(MemberVO member);
	

		
	
}
