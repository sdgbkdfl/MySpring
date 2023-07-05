package com.momo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.momo.service.BoardService;
import com.momo.vo.BoardVO;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board/*")
@Log4j //log.info() :  INFO 레벨의 로그 메시지가 출력
public class BoardController {

	/**
	 * /board/msg
	 *  WEB-INF/views/board/message
	 *  
	 * @param model
	 */
	//왜 메세지 메서드가 두개지..?
	//message는 모달창으로 만들어준거인듯
	@GetMapping("msg")
	public void msg() {
		
	}
	@GetMapping("message")
	public void message(Model model) {
		
	}
	@GetMapping("list_bs")
	public void list_bs(Model model) {
		
	}
	@Autowired
	BoardService boardService;
	//BoardService타입의 빈을 컨텍스트에서 찾아서 
	//boardService 필드에 주입
	
	@GetMapping("list")
	public void getList(Model model) {
		List<BoardVO> list = boardService.getListXml();
	    log.info("list");
	    
	    model.addAttribute("list", list);

	}
	@GetMapping("view")
	public void getOne(Model model, BoardVO paramVo) {
		log.info("bno"+paramVo);
		model.addAttribute("board", boardService.getOne(paramVo.getBno()));

//		BoardVO board = boardService.getOne(paramVO.getBno());
//		model.addAttribute("board", board);
	}
	
	/**
	 * RequestMapping에 /board/가 설정되어있으므로
	 * /board/write
	 * 
	 * @param model
	 * @return
	 */
	@GetMapping("write")
	public void write(Model model) {

		
	}
	
	/**
	 * RedirectAttributes
	 * 리다이렉트 URL의 화면까지 데이터를 전달
	 * 
	 * addAttribute : 주소 표시줄에 표시됨 url?msg=등록 (쿼리스트링으로 넘어감 ->param.meg로 받아야함)
	 * addFlashAttribute : 세션에 저장 후 페이지 전환 (msg로 작성하여 출력 가능)
	 * 
	 * @param board
	 * @param rttr
	 * @param model
	 * @return
	 */
	@PostMapping("write")
	public String writeAction(BoardVO board, RedirectAttributes rttr, Model model) {
		log.info(board);

		//시퀀스 조회후 시퀀스 번호를 bno에 저장
		int res = boardService.insertSelectKey(board);
		
		String msg = "";
		
		if(res > 0) {
			msg = board.getBno() + "번 등록되었습니다";
			rttr.addFlashAttribute("msg", msg);
			//rttr.addAttribute("msg", msg);
			return "redirect:/board/list";
			//redirect : 저장한 데이터가 그대로 유지되지 않음
			//다른 방법 : RedirectAttributes 사용
		}else {
			msg = "등록 중 예외 발생하였습니다.";
			model.addAttribute("msg", msg);
			return "/board/message";
			
		}
		
	}
	@GetMapping("edit")
	public String edit(BoardVO paramVo, Model model){
		BoardVO board = boardService.getOne(paramVo.getBno());
		model.addAttribute("board", board);
		return "/board/write";
	}
}
