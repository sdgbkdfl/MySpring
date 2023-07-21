package com.momo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.momo.vo.BoardVO;
import com.momo.vo.Criteria;

public interface BoardMapper {
	
	@Select("select*from tbl-board")
	public List<BoardVO> getList();
	
	public List<BoardVO> getListXml(Criteria cri);
	
	public int insert(BoardVO board);
	
	public int insertSelectKey(BoardVO board);
	
	public BoardVO getOne(int bno);
	
	public int delete(int bno);
	
	public int update(BoardVO board);

	public int getTotalCnt(Criteria criteria);
	
	// 매개 변수 두개 이상은 Param 어노테이션 꼭 붙여줘야 인식됨
	// 안그러면 첫번째 매개변수만 인식됨
	public int updateReplyCnt(@Param("bno")int bno, @Param("amount") int amount);
}
