package com.momo.mapper;


import com.momo.vo.MemberVO;

public interface MemberMapper {

	public MemberVO login(MemberVO member);

	public int register(MemberVO member);

	public int idCheck(MemberVO member);



}