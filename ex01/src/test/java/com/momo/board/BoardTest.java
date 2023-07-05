package com.momo.board;

import static org.junit.Assert.assertEquals;
import static org.junit.Assume.assumeNotNull;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.momo.mapper.BoardMapper;
import com.momo.vo.BoardVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardTest {
	@Autowired
	BoardMapper boardMapper;
	
	@Test
	public void getList() {
		assumeNotNull(boardMapper);
		List<BoardVO> list = boardMapper.getList();
		
		list.forEach(board->{
			log.info(board.getBno());
			log.info(board.getTitle());
			log.info(board.getContent());
			});
	}
	@Test
	public void getListXml() {
		List<BoardVO> list = boardMapper.getListXml();
		list.forEach(board->{
			log.info(board.getBno());
			log.info(board.getTitle());
			log.info(board.getContent());
		});
	}
	
	@Test
	public void insert() {
		BoardVO board = new BoardVO();
		
		board.setTitle("제목");
		board.setContent("내용");
		board.setWriter("글쓴이");
		
		int res = boardMapper.insert(board);
		
		assertEquals(res, 1);
	}
	@Test
	public void insertSelectKey() {
		BoardVO board = new BoardVO();
		board.setTitle("제목 selectKey");
		board.setContent("내용");
		board.setWriter("글쓴이");
		
		int res = boardMapper.insertSelectKey(board);
		log.info("bno :"+board.getBno());
		assertEquals(res, 1);
	}
	
	@Test
	public void getOne() {
		//존재하는 게시물 번호로 테스트
		BoardVO board = boardMapper.getOne(10);
		log.info(board);
		
	}
	@Test
	public void delete() {
		int res = boardMapper.delete(11); //int 타입 반환
		assertEquals(res, 1);
	}
	@Test
	public void update() {
		int bno =11;
		BoardVO board = new BoardVO();
		
		board.setBno(11);
		board.setTitle("제목 update");
		board.setContent("내용");
		board.setWriter("글쓴이");
		
		int res = boardMapper.update(board);
		
		BoardVO getBoard = boardMapper.getOne(bno);
		assertEquals("제목 update", getBoard.getTitle());
	}
	@Test
	public void getTotalCnt() {
		int res =  boardMapper.getTotalCnt();
		log.info("totalCnt :" +res);
	}
}
