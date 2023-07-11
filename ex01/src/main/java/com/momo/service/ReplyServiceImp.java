package com.momo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.momo.mapper.ReplyMapper;
import com.momo.vo.Criteria;
import com.momo.vo.ReplyVO;

@Service
public  class ReplyServiceImp implements ReplyService {

	@Autowired
	ReplyMapper replyMapper;
	
	@Override
	public List<ReplyVO> getList(int bno, Criteria cri){
		return replyMapper.getList(bno, cri);
	}

	@Override
	public int insert(ReplyVO replyVo) {
		return replyMapper.insert(replyVo);
	}

	@Override
	public int delete(int rno) {
		return replyMapper.delete(rno);
	}
	
	@Override
	public int update(ReplyVO replyVo) {
		return replyMapper.update(replyVo);
	}

	@Override
	public int totalCnt(int bno) {
		return replyMapper.totalCnt(bno);
	}

	
}
