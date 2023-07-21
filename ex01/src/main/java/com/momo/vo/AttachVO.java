package com.momo.vo;

import lombok.Data;

@Data //setter getter 자동 생성
public class AttachVO {
	private String uuid; // 
	private String uploadPath; // 업로드 경로 
	private String fileName; // 업로드 명 
	private String filetype; //업로드 타입
	private int bno; // 
	
	// 저장된 파일 경로
	private String savePath;
	private String s_savePath; //썸네일 이미지
}
