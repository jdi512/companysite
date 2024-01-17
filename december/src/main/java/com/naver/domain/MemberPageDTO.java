package com.naver.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class MemberPageDTO {

	private int startPage;//시작페이지
	private int endPage;//끝페이지
	private boolean prev, next;//이전,다음 여부
	
	private int total;//전체 글수
	
	private MemberCriteria cri;//현재페이지, 한페이지당보여줄갯수
	
	public MemberPageDTO(MemberCriteria cri, int total) {
		this.cri = cri;
		this.total = total;
		//끝페이지
		this.endPage = (int) (Math.ceil(cri.getPageNum() / 10.0)) * 10;
		//시작페이지
		this.startPage = this.endPage - 9;
		//실제 끝페이지
		int realEnd = (int) (Math.ceil((total * 1.0) / cri.getAmount()));
		
		//실제페이지가 끝페이지보다 작으면 실제마지막페이지를 끝페이지에 저장한다.
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		//시작페이지가 1페이지가 아니면 이전버튼을 보이게 한다.
		this.prev = this.startPage > 1;
		//끝페이지가 실제마지막페이지보다 작으면 다음버튼을 보이게 한다.
		this.next = this.endPage < realEnd;
	}
}
