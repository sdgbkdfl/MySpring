package com.momo.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.momo.service.MemberService;
import com.momo.vo.MemberVO;

@Controller
public class MemberController extends CommonRestController {
	
	/*@Autowired
	 * 	필드, 생성자, Setter 메서드 등에 적용하여
	 *  해당 컴포넌트나 빈(Bean)에 자동으로 의존성을 주입
	 * 
	 * */
	
	@Autowired
	MemberService service;
	
	/**
	 * 로그인 페이지로 이동
	 * @return
	 */
	@GetMapping("/login")
	public String login() {
		return "login";
	}
	
	@GetMapping("/board/login")
	public String boardlogin() {
		return "/board/login";
	}
	
	// 로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		// 현재 세션을 무효화하여 로그아웃 처리를 수행
		session.invalidate();
		return "/board/login";
	}
	
	
	/*
	 * json형식의 데이터를 주고 받고 싶음
	 * 페이지를 갱신하지 않고 원하는 데이터만 요청
	 * */
	@PostMapping("/loginAction")
	public @ResponseBody Map<String, Object> loginAction(@RequestBody MemberVO member, 
															Model model, 
															HttpSession session) {
		System.out.println("id : " + member.getId());
		System.out.println("pw : " + member.getPw());

		
		member = service.login(member);
		//model.addAttribute("message", member.getId() + "환영합니다.");


		if(member != null) {
			session.setAttribute("member", member);
			session.setAttribute("userId", member.getId());
			// userId : header.jsp에서 로그아웃 처리할때도 사용
			
			return responseMap(1,"로그인");
		}else {
			return responseMap(0,"로그인");
		}
	}
	
	@PostMapping("/idCheck")
	public @ResponseBody Map<String, Object> idCheck(@RequestBody MemberVO member){
		int res = service.idCheck(member);
		
		if(res == 0) {
			// count = 1이면 fail(회원가입 불가) (res, msg)
			return responseMap(REST_SUCCESS,"로그인 되었습니다.");
		}else {
			return responseMap(REST_FAIL,"아이디 비밀번호를 확인바랍니다.");	
		}
	}
	@PostMapping("/register")
	public @ResponseBody Map<String, Object> register(@RequestBody MemberVO member){
		
		try {
			int res = service.register(member);
			return responseWriteMap(res);
			
		}catch(Exception e){
			e.printStackTrace();
			return responseMap(REST_FAIL, "등록 중 예외사항 발생하였습니다.");
		}
	}
	
}















