package com.momo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.momo.vo.Criteria;
import com.momo.vo.ReplyVO;

public interface ReplyMapper {
	
	/**
	 * 매개변수가 두 개 이상 파라미터로 전달되는 경우
	 * 앞의 변수 하나만 인식되므로!
	 *
	 *  방법1: 새로운 객체로 두 변수 받아 사용
	 *  방법2: Param 어노테이션 사용 (✔️)
	 *  
	 * @param bno
	 * @param cri
	 * @return
	 */
	
	// 리스트 조회 및 페이징 처리
	public List<ReplyVO> getList(@Param(value= "bno") int bno, @Param(value="cri") Criteria cri);
	
	//댓글 작성
	public int insert(ReplyVO replyVo);
	
	// 댓글 삭제
	public int delete(int rno);
	
	// 댓글 수정
	public int update(ReplyVO replyVo);
	
	//댓글 총건수 구하기
	public int totalCnt(int bno);
	
	//??
	public ReplyVO getOne(int rno);
	
	
}
