package com.momo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.momo.vo.AttachVO;
import com.momo.vo.Criteria;
// 첨부 파일 
public interface AttachMapper {

	// 조회 - 하나의 게시물 당 첨부 파일 목록 (bno)
	public List<AttachVO> getList(int bno);
	
	// 등록
	public int insert(AttachVO attach);
	
	// 삭제
	public int delete(@Param("bno") int bno, @Param("uuid") String uuid);
	
	// 다운로드
	public AttachVO getOne(@Param("bno") int bno, @Param("uuid") String uuid);
	
}
