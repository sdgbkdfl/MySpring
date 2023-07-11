package com.momo.exception;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.servlet.NoHandlerFoundException;

import lombok.extern.log4j.Log4j;

@RestControllerAdvice
@Log4j
public class CommonRestExceptionAdvice {

	@ExceptionHandler(Exception.class)
	public Map<String,Object> except(Exception ex, Model model) {
		System.out.println("RestException..."+ex.getMessage());
		log.info("RestException....");
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("result", "fail");
		map.put("message", ex.getMessage());
		
		
		return map;
	}
	
	@ExceptionHandler(NoHandlerFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public String handle404(NoHandlerFoundException ex) {
		return "/error/error404";
	}
}
