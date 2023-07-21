package com.momo.intercepter;

import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

/**Spring intercepter
 * 		HTTP 요청 처리 과정에서 요청을 가로채고 처리 전후에 추가 작업을 수행
 * 		인터셉터는 컨트롤러(Controller)에 진입하기 전, 컨트롤러 실행 후
 * 		, 뷰(View) 렌더링 전 등 다양한 시점에서 동작
 * 		사용하여 요청의 처리 흐름을 제어하거나 조작 할 수 있습니다.
 * 
 * 		인증 및 권한 체크로직을 작성해봅시다
 * 
 */
@Component
public class LoginInterceptor implements HandlerInterceptor{
	// 인터셉터는 HandlerInterceptor의 구현체이다.
	/**
	 * 컨트롤러 실행 전 실행
	 * return true : 요청 컨트롤러 실행
	 *        false : 요청 컨트롤러 실행 하지 않음
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		if(session.getAttribute("userId")==null
				|| session.getAttribute("userId").toString() == "") {
			// 로그인 페이지로 이동
			//interceptor에서 한글처리 자동안됨
			String msg = URLEncoder.encode("로그인 후 사용가능합니다.", "utf-8");
			response.sendRedirect("/board/login?msg="+msg);
			return false;
		}
		return true;
	}
}

