package com.momo.vo;

import lombok.Data;

//페이징 처리를 위한 클래스

@Data
public class PageDto {
	
	private Criteria cri; //페이지 번호, 페이지당 게시물 수 
	private int totalCnt; // 총 게시물의 수
	
	private int startNo; //페이지 블럭의 시작번호
	private int endNo; //페이지 블럭의 끝번호
	
	//버튼에 대한 활성화 처리
	private boolean prev, next; //이전 다음 버튼
	
	int realEndNo; //진짜 끝번호
	
	
	//생성자 
	public PageDto(Criteria cri, int totalCnt){
		this.cri = cri;
		this.totalCnt = totalCnt;
		
		//페이지 블럭의 끝번호(공식처럼 생각할 것)
		this.endNo = (int)(Math.ceil(cri.getPageNo()/10.0) * 10);
		//페이지 블럭의 시작 번호
		this.startNo = this.endNo-9;
		
		//총게시물의 수를 페이지당 보여지는 게시물의 수로 나눠 실제 끝페이지 번호 구함
		realEndNo = (int)(Math.ceil((totalCnt*1.0)/cri.getAmount()));
		endNo = endNo>realEndNo ? realEndNo :endNo;
		prev = startNo >1? true : false;
		next = (endNo == realEndNo) ? false : true;
	}
}
