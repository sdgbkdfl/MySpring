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
import com.momo.vo.Criteria;

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
	
	/**
	 * 파라메터의 자동수집
	 * 기본생성자를 이용해서 객체 생성
	 * → setter메서드 이용해서 세팅
	 * @param model
	 * @param cri
	 */
	@GetMapping("list")
	public void getList(Model model, Criteria cri) {
		//서비스 호출
		//List<BoardVO> list = 
				
		boardService.getListXml(cri, model);
		
		log.info("=========list");
//		log.info("list:" +list);
	    log.info("cri :"+cri);
	    
//	    model.addAttribute("list", list);
// 알림주기 위해 model객체를 서비스에 전달하여 service에서 알림 처리..	    

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
		//게시물 정보 조회
		BoardVO board = boardService.getOne(paramVo.getBno()); 
		model.addAttribute("board", board);
		/**
		 * 수정하기
		 * - bno를 파라메터로 받아야함
		 * - 버튼, 버튼 액션 달라짐
		 * 
		 */
		return "/board/write";
	}
	@PostMapping("editAction")
	public String editAction(BoardVO board, RedirectAttributes rttr ,Model model){
		//수정
		int res = boardService.update(board);
		
		if(res > 0) {
			//redirect시 request영역 공유 되지 않으므로 RedirectAttributes 이용.
			
			//model.addAttribute("msg","수정되었습니다.");
			rttr.addFlashAttribute("msg","수정되었습니다.");
			
			//상세페이지로 이동
			return "redirect:/board/view?bno="+board.getBno();
			
		}else {
			//model객체로 메세지 담아주기
			model.addAttribute("msg","수정 중 예외 발생😖");
			return "/board/message";
		}
		
	
	}
	
	@GetMapping
	public String delete(BoardVO board, RedirectAttributes rttr, Model model) {
		int res = boardService.delete(board.getBno());

		if(res > 0) {
			rttr.addFlashAttribute("msg","삭제되었습니다.");
			return "redirect:/board/list";
			
		}else {
			model.addAttribute("msg", "삭제중 예외 발생");
			return "/board/message";
		}
	}
	
	
	
}
