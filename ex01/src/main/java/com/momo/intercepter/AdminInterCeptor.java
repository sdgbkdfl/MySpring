package com.momo.intercepter;

import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.momo.vo.Member;

@Component
public class AdminInterCeptor implements HandlerInterceptor {

	/**
	 * 컨트롤러 실행 전 실행
	 * return true : 요청 컨트롤러 실행
	 *        false : 요청 컨트롤러 실행 하지 않음
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		//세션에 저장되어 있는 사용자 정보로 판단
		HttpSession session = request.getSession();
		
		if(session.getAttribute("member") !=null) {
			Member member = (Member) session.getAttribute("member");
			List<String> role = member.getRole();
			if(role != null){
				if(role.contains("ADMIN_ROLE")) {
				return true;
				}
			}
		}
		//로그인 페이지로 이동
		String msg = URLEncoder.encode("로그인 후 사용가능한 메뉴입니다.", "utf-8");
		response.sendRedirect("/board/login?msg="+msg);
		return false;
	}
}
