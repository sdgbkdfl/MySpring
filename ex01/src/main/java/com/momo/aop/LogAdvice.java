package com.momo.aop;

import java.util.Arrays;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StopWatch;

import com.momo.service.LogService;
import com.momo.vo.LogVO;

import lombok.extern.log4j.Log4j;

/**
 * AOP(Aspect-Oriented Programming) 
 * 		관점지향프로그래밍
 * 		핵심비지니스 로직과 부가적인 관심사를 분리하여 개발하는 방법론
 * 
 * 		코드의 중복을 줄이고 유지보수성을 향상 시킬수 있습니다.
 * 
 * 부가적인 관심사
 * 		로깅, 보안, 트랜젝션관리등 
 * 		애플리케이션에서 공통적으로 처리해야 하는 기능
 * 		오류 발생 시 데이터 베이스에 저장
 *		
 * Aspect
 * 		부가적인 관심사를 모듈화한 단위
 * 		(Advice를 그룹화)Cross Concern : 횡단관심사
 * 		주 업무로직 이외의 부가적인 기능을 의미
 * 
 * Advice
 * 		부가적인 관심사
 *  
 * Pointcut
 * 		부가기능이 적용되는 지점
 * 
 * Target
 * 		핵심 기능을 구현한 객체
 * 		(Core Concern: 핵심관심사)
 * 
 * Proxy
 * 		Target + Advice
 * 
 * @author user
 *
 */
@Aspect
@Log4j
@Component //자바빈으로 등록
public class LogAdvice {

	/**
	 * 포인트 컷 : 언제 어디에 적용할 것인가?
	 * (어노테이션 달아줌)
	 * 
  	 * Before
	 *	타겟 객체의 메소드가 실행되기 전에 호출되는 어드바이스
	 * 	JoinPoint를 통해 파라미터 정보 참조 가능
	 */
	 //* : 접근제한자 , 패키지 포함 경로 
	//com.momo.service 패키지 내의 Board로 시작하는 클래스의 모든 메소드를 대상으로 설정된 어드바이스를 실행하도록 지정
//	@Before	("execution(* com.momo.service.Board*.*(..))")
//	public void logBefore() {
//		 log.info("========================");
//
//	 }
	
	/**
	 *  joinPoint
	 *  	타겟에 대한 정보와 상태를 담고 있는 객체로 매개변수로 받아서 사용
	 *  
	 * @param joinPoint
	 */
	// com.momo.service.Reply 클래스의 모든 메서드 실행 이전에 실행
	@Before("execution(* com.momo.service.Reply*.*(..))")
	public void logBeforeParams(JoinPoint joinPoint) {
		log.info("=======aop=======");
		log.info("param :"+Arrays.toString(joinPoint.getArgs()));
		log.info("target :"+joinPoint.getTarget());
		log.info("method :"+joinPoint.getSignature().getName());
	}
	/**
	 * Around
	 * 		타겟의 메소드가 호출되기 이전 시점과 이후 시점에 모두 처리해야
	 * 		할 필요가 있는 부가 기능 정의
	 * 		
	 * 		주업무로직을 실행 하기 위해	JoinPoint의 하위 클래스인 
	 * 		ProceedingJoinPoint타입의	파라미터를 필수적으로 선언해야 함
	 * 
	 * @param pjp
	 * @return
	 */
	// around의 경우 타겟을 직접 실행해야함
	// 따라서 ProceedingJoinPoint(타겟 메서드 실행 역할)를 반드시 써줘야함
	@Around("execution(* com.momo.service.Board*.*(..))")
	public Object logTime(ProceedingJoinPoint pjp) {
		//ProceedingJoinPoint : 실행결과 알 수 있음
		StopWatch stopWatch = new StopWatch();
		stopWatch.start();
		
		Object res = "";
		// 주업무로직 실행(타겟 메서드의 실행시점 정할 수 있음)
		try {
			res = pjp.proceed();
		} catch (Throwable e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			stopWatch.stop();
			log.info("===============================");
			log.info(pjp.getTarget()+"."+pjp.getSignature().getName());
			log.info("수행시간:"+stopWatch.getTotalTimeMillis()+"(ms)초");
			log.info("===============================");
			return res;
	}
	
	@Autowired
	LogService logService;
	
	/**
	 * AfterThrowing
	 * 		타겟 메서드 실행중 예외가 발생한 뒤에 실행할 부가기능
	 * 		오류가 발생내역을 테이블에 등록
	 * @param joinPoint
	 * @param exception
	 */
	// 예외 발생시 실행 메서드
	@AfterThrowing(pointcut="execution(* com.momo.service.*.*(..))", throwing = "exception")
	public void logException(JoinPoint joinPoint, Exception exception) {
		// 예외 발생 시 테이블에 저장
		
		try {
			LogVO vo = new LogVO();
			
			vo.setClassname(joinPoint.getTarget().getClass().getName());
			vo.setMethodname(joinPoint.getSignature().getName());
			vo.setParam(Arrays.toString(joinPoint.getArgs()));
			vo.setErrmsg(exception.getMessage());
			int res = logService.insert(vo);
			log.info("=====로그 테이블 저장 : "+res);
		}catch(Exception e) {
			log.info("로그저장 중 예외발생");
			log.info(e.getMessage());
			e.printStackTrace();
		}
	}
}
