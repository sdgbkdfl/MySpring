package com.momo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.momo.vo.Criteria;
import com.momo.vo.ReplyVO;

@Service
public interface ReplyService {

	List<ReplyVO> getList(int bno, Criteria cri);

	int insert(ReplyVO replyVo);
	
	int delete(int rno);

	int update(ReplyVO replyVo);
	
	int totalCnt(int bno);
	

}
