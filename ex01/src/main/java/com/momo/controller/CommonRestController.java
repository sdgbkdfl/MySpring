package com.momo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.momo.vo.PageDto;

public class CommonRestController {
	
	private final String REST_WRITE = "등록";
	private final String REST_EDIT = "수정";
	private final String REST_DELETE = "삭제";
	private final String REST_SELECT = "조회";
	protected final String REST_SUCCESS = "success";
	protected final String REST_FAIL = "fail";
	
	/**
	 * 입력, 수정, 삭제의 경우 int 값을 반환
	 * 결과 값 받아서 map 생성 후 반환
	 */
	//map 생성 후 result, msg 세팅
	public Map<String, Object> responseMap(int res, String msg){	
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(res > 0) {
			map.put("result", REST_SUCCESS);
			map.put("msg", msg + "되었습니다.");
		}else {
			map.put("result", REST_FAIL);
			map.put("msg", msg + "중 예외 발생하였습니다.");
		}
		return map;
	}
	
	public Map<String, Object> responseMapMessage(int res, String msg){	
		Map<String, Object> map = new HashMap<String, Object>();
		if(res > 0) {
			map.put("result", res);
		}else {
			map.put("msg", msg );

	}
		return map;
	}	
	public Map<String, Object> responseWriteMap(int res){
		return responseMap(res, REST_WRITE);
	}
	
	public Map<String, Object> responseEditMap(int res){
	
	/*	
	Map<String, Object> map = new HashMap<String, Object>();
		
		if(res > 0) {
			map.put("result", "success");
			map.put("msg", msg + "수정되었습니다.");
		}else {
			map.put("result", "fail");
			map.put("msg", msg + "중 예외 발생하였습니다.");
		}
		return map;
	 */
		
		return responseMap(res, REST_EDIT);
	}
	
	public Map<String, Object> responseDeleteMap(int res){
		return responseMap(res, REST_DELETE);
	}
	
	public Map<String, Object> responseListMap(List<?> list
												, PageDto pageDto){
		
		int res = list != null ? 1 : 0;
		Map<String, Object> map = responseMap(res, REST_SELECT);
		map.put("list", list);
		map.put("pageDto", pageDto);
		return map;
	}
	
	// 0714 메서드 넣어주기
	// responseMap() 메서드로, 결과와 메세지를 담은 Map 객체를 생성하여 반환
	public Map<String, Object> responseMap(String result
												, String msg){
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("result", result);
		map.put("msg", msg);
		
		return map;
		}
}
