package com.momo.vo;

import lombok.Data;

@Data
public class Criteria {

	private String searchField; //검색 조건
	private String searchWord;  //검색어

	int pageNo =1; // 요청 페이지 번호
	int amount = 10; //한 페이지당 게시물 수
	
	int startNo = 1;
	int endNo = 10;
	
	//얘만 왜 따로 뺴서 만들어줬지?
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
		
		if(pageNo > 0) {
			endNo = pageNo * amount;
			startNo = pageNo * amount - (amount-1);
		}
	}
}
