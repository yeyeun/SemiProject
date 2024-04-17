package com.raon.domain;

import lombok.Data;

@Data
public class PageDTO {
	private Integer start; //시작 페이지 번호
	private Integer end; //끝 페이지 번호
	private boolean prev, next; //이전,다음 버튼 활성화 여부
	private Integer total; //총 게시글 수
	private Criteria cri;
	
	public PageDTO(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;
		this.end = (int)(Math.ceil(cri.getPageNum()/10.0))*10;
		this.start = this.end - 9; //시작값은 끝값에서 9만큼 뺀 값
		
		//전체 마지막 페이지
		int realEnd = (int)(Math.ceil((total*1.0)/cri.getAmount()));
		
		//realend가 화면에 보이는 end보다 작은 경우, end 값 조정
		if(realEnd<this.end) {
			this.end = realEnd;
		}
		this.prev = this.start>1; //start값이 1보다 큰 경우 : true
		this.next = this.end<realEnd; //end값이 1보다 큰 경우 : true
	}
}
