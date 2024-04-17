package com.raon.domain;

import lombok.Data;

@Data
public class Criteria {
	private Integer pageNum; //페이지번호
	private Integer amount; //1페이지당 게시글 수
	private Integer skip; //스킵할 게시물수  ( (pageNum-1) * amount )
	private String searchField; //검색할 필드
	private String searchWord; //검색할 키워드

	public Criteria() { //기본 생성자
		this.pageNum = 1;
		this.amount = 10;
		this.skip = 0;
	}
	
	public Criteria(Integer pageNum, Integer amount) {
		this.pageNum = pageNum;
		this.amount = amount;
		this.skip = (pageNum-1) * amount;
	}
	
	public void setPageNum(Integer pageNum) {
		this.skip = (pageNum-1) * this.amount;
		this.pageNum = pageNum;
	}
	
	public void setAmount(int amount) {
		this.skip = (this.pageNum-1) * amount;
		this.amount = amount;
	}


	
}
