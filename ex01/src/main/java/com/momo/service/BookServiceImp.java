package com.momo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.momo.mapper.BookMapper;
import com.momo.vo.BookVO;
import com.momo.vo.Criteria;
import com.momo.vo.PageDto;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class BookServiceImp implements BookService {

	@Autowired
	BookMapper bookMapper;

	@Override
	public List<BookVO> getList(Criteria cri, Model model) {
		/**
		 * 1. 리스트 조회
		 * 2. 총건수 조회
		 * 3. 페이지DTO 생성(페이지 블럭)
		 */
		List<BookVO> list = bookMapper.getList(cri);
		
		int totalCnt = bookMapper.getTotalCnt(cri);
		
		//게시물의 총건수로 페이지 블럭 생성
		PageDto pageDto = new PageDto(cri, totalCnt);
		
		log.info("pageDto : "+ pageDto);
		
		model.addAttribute("list", list);
		model.addAttribute("pageDto", pageDto);
		//model.addAttribute("totalCnt", totalCnt);
		//pageDto에 totalCnt 데이터 들어있음
		return bookMapper.getList(cri);
	}
	@Override
	public BookVO getOne(String no, Model model ) {
		BookVO book = bookMapper.getOne(no);
		model.addAttribute("book", book);
		return book;
	}

	@Override
	public int getTotalCnt(Criteria criteria) {
		return bookMapper.getTotalCnt(criteria);
	}





}
