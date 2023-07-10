package com.momo.mapper;

import java.util.List;

import com.momo.vo.ReplyVO;

public interface ReplyMapper {
	public List<ReplyVO> getList(int bno);

	public int insert(ReplyVO replyVo);
	
	public int delete(int rno);
	
	//댓글 수정
	public int update(ReplyVO replyVoo);
	
}
