package com.naver.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {

	private int startPage;//�떆�옉�럹�씠吏�
	private int endPage;//�걹�럹�씠吏�
	private boolean prev, next;//�씠�쟾,�떎�쓬 �뿬遺�
	
	private long total;//�쟾泥� 湲��닔
	
	private Criteria cri;//�쁽�옱�럹�씠吏�, �븳�럹�씠吏��떦蹂댁뿬以꾧갗�닔
	
	public PageDTO(Criteria cri, long total) {
		this.cri = cri;
		this.total = total;
		//�걹�럹�씠吏�
		this.endPage = (int) (Math.ceil(cri.getPageNum() / 10.0)) * 10;
		//�떆�옉�럹�씠吏�
		this.startPage = this.endPage - 9;
		//�떎�젣 �걹�럹�씠吏�
		int realEnd = (int) (Math.ceil((total * 1.0) / cri.getAmount()));
		
		//�떎�젣�럹�씠吏�媛� �걹�럹�씠吏�蹂대떎 �옉�쑝硫� �떎�젣留덉�留됲럹�씠吏�瑜� �걹�럹�씠吏��뿉 ���옣�븳�떎.
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		//�떆�옉�럹�씠吏�媛� 1�럹�씠吏�媛� �븘�땲硫� �씠�쟾踰꾪듉�쓣 蹂댁씠寃� �븳�떎.
		this.prev = this.startPage > 1;
		//�걹�럹�씠吏�媛� �떎�젣留덉�留됲럹�씠吏�蹂대떎 �옉�쑝硫� �떎�쓬踰꾪듉�쓣 蹂댁씠寃� �븳�떎.
		this.next = this.endPage < realEnd;
	}
}
