package com.momo.vo;


import java.sql.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class MemberVO {
	private String id;
	private String pw;
	private String name;
	private String adminyn;
	private String status;
	private String grade;

	// 사용자 권한
	private List<String> role;
	
	@DateTimeFormat(pattern = "yyyy/MM/dd")
	private Date dueDate;
	
}
