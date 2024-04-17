package com.raon.domain;

import lombok.Data;

@Data
public class PageDTO {
	private Integer start; //시작 페이지 번호
	private Integer end;
	private boolean prev, next; //이전,다음 버튼 활성화 여부
	private Integer total; //총 게시글 수
	private Criteria cri;
	
	public PageDTO(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;
		this.end = (int)(Math.ceil(cri.getPageNum()/10.0))*10;
		this.start = this.end - 9; //시작값은 끝값에서 9만큼 뺀 값
		int realEnd = (int)(Math.ceil((total*1.0)/cri.getAmount()));
		if(realEnd<this.end) {
			this.end = realEnd;
		}
		this.prev = this.start>1;
		this.next = this.end<realEnd;
	}
}
