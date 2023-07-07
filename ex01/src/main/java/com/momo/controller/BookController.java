package com.momo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.momo.service.BookService;
import com.momo.vo.BookVO;
import com.momo.vo.Criteria;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/book/*")
@Log4j
public class BookController {
	
	@Autowired
	BookService bookservice;
	
	// cri : 검색조건과 페이지 정보를 담고 있는 객체
	@GetMapping("booklist")
	public void getList(Criteria cri, Model model) {
		
		log.info("cri : " + cri);
		//리스트 조회
		bookservice.getList(cri, model);
		
		//log.info("list"+list);
		//화면에 전달
		model.addAttribute("msg","/book/booklist" );
		//return "/book/booklist";
		// -> WEB_INF/views/book/booklist.jsp
	}
	
	@GetMapping("view")
	public void getOne(BookVO book, Model model) {
		bookservice.getOne(book.getNo(), model);
		//model.addAttribute("bookVo", book);
		
	}
}
