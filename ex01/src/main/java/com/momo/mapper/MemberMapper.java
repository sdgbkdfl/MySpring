package com.momo.mapper;


import java.util.List;

import com.momo.vo.MemberVO;

public interface MemberMapper {

	public MemberVO login(MemberVO paramMember);

	public int register(MemberVO member);

	public int idCheck(MemberVO member);

	public List<String> getMemberRole(String id);



}