package com.momo.vo;

import lombok.Data;

@Data
public class BookVO {

		private String no;		// 도서 일련번호
		private String title;	// 도서명
		private String author;	// 작가

		
		private String sfile;	// 저장된 파일명
		private String ofile;	// 원본 파일명
		
		private String id; //대여자 아이디
		private String rentyn; //도서 대여여부
		private String rentStr; //사용자 화면
		
		private String rentno; //대여번호
		private String startDate; //대여시작일
		private String endDate; //반납가능일
		private String returnDate; //반납일
}
