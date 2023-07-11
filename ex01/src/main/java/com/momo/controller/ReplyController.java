package com.momo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.momo.service.ReplyService;
import com.momo.vo.Criteria;
import com.momo.vo.PageDto;
import com.momo.vo.ReplyVO;

import lombok.extern.log4j.Log4j;

/**
 * RestController
 *  Controller가 Rest방식을 처리하기 위한 것임을 명시
 *  
 * @author user
 *
 */

@RestController
@Log4j
public class ReplyController {
 
	
	@Autowired
	ReplyService service;
	
	
	@GetMapping("/test")
	public String test() {
		return "test";
	}
	
	/**
	 * PathVariable
	 * 	URL경로에 있는 값을 파라미터로 추출(사용)하려고 할때 사용
	 * 	(url로 부터 파라메터 획득가넝)
	 * 
	 * 	변수로 사용코자하는 부분은 중괄호로 묶음{}
	 *  getList() 메서드가 PathVariable을 사용하여 URL 경로에서 bno와 page 값을 가져오고, 
	 *  해당 값을 기반으로 댓글 리스트와 페이지 정보를 조회하여 반환하는 코드
	 *  
	 * 	리스트 조회 및 페이징 처리
	 * @return
	 */
	@GetMapping("/reply/list/{bno}/{page}")
	// URL 경로에서 bno와 page 값을 가져옴
	public Map<String, Object> getList(@PathVariable("bno") int bno,
									@PathVariable("page") int page){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		log.info("bno" + bno);
		log.info("page" + page);
		
		// 가져온 bno와 page 값을 기반으로 Criteria 객체를 생성하고 페이지 번호를 설정
		Criteria cri = new Criteria();
		cri.setPageNo(page);
	
		// 페이지 처리(시작번호~끝번호)
		// bno와 Criteria 객체를 사용하여 댓글 리스트를 조회
		List<ReplyVO> list = service.getList(bno, cri);
		// bno를 사용하여 전체 댓글 수를 조회
		int totalCnt = service.totalCnt(bno);
		
		// 페이지 블럭 생성
		PageDto pageDto = new PageDto(cri, totalCnt);
		
		// 조회된 댓글 리스트와 페이지 정보를 Map 객체에 담아 반환
		map.put("list",list);
		map.put("pageDto",pageDto);
		
		return map;
	}
	
	
	/**
	 * RequestBody
	 * 	json 데이터를 원하는 타입(EX: map)으로 바인딩 처리
	 *	파라메터의 자동수집 역할 
	 * @param replyVo
	 * @return
	 */
	@PostMapping("/reply/insert")
	public Map<String, Object> insert(@RequestBody ReplyVO replyVo){
		int res = service.insert(replyVo);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(res>0) {
			map.put("result", "success");
		}else {
			map.put("result","fail");
			map.put("message", "댓글 등록 중 오류가 발생하였습니다.");
		}
		return map;
	}
	
	@GetMapping("/reply/delete/{rno}")
	public Map<String, Object> delete(@PathVariable("rno") int rno){
		Map<String, Object> map = new HashMap<String, Object>();

		int res = service.delete(rno);

		if(res>0) {
			map.put("result", "success");
		}else {
			map.put("result","fail");
			map.put("message", "댓글 삭제 중 오류가 발생하였습니다.");
		}
		
		return map;
	}
	
	/**
	 * update
	 * @param replyVo
	 * @return
	 */
	@PostMapping("/reply/editAction")
	public Map<String, Object> update(@RequestBody ReplyVO replyVo){
		
		Map<String, Object> map = new HashMap<String, Object>();
		int res = service.update(replyVo);
		
		if(res>0) {
			map.put("result", "success");
		}else {
			map.put("result","fail");
			map.put("message", "댓글 수정 중 오류가 발생하였습니다.");
		}
		return map;
	}
		
	
}
