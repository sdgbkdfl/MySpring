package com.momo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.momo.mapper.BoardMapper;
import com.momo.mapper.ReplyMapper;
import com.momo.vo.Criteria;
import com.momo.vo.ReplyVO;

@Service
public  class ReplyServiceImp implements ReplyService {

	@Autowired
	ReplyMapper replyMapper;
	
	@Autowired
	BoardMapper boardMapper;
	
	@Override
	public List<ReplyVO> getList(int bno, Criteria cri){
		return replyMapper.getList(bno, cri);
	}

	/**
	 * Transactional
	 * 	서비스 로직에 대한 트랜젝션 처리를 지원
	 * 	(bean으로 올린 다음 어노테이션 달아 사용)
	 *  트랜젝션이 댓글 오류 로그 저장 보다 밖에 있어서 잠시 주석처리
	 */
//	@Transactional
	@Override
	public int insert(ReplyVO replyVo) {
		// 댓글 입력시 board테이블의 댓글 수(replyCnt) 1증가
		boardMapper.updateReplyCnt(replyVo.getBno(),1);
		return replyMapper.insert(replyVo);
	}

	@Override
	public int delete(int rno) {
		ReplyVO replyVo = replyMapper.getOne(rno);
		boardMapper.updateReplyCnt(replyVo.getBno(), -1);
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
