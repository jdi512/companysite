package com.naver.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
	
	private Long bno;
	
	private String boardId;	

	protected int pageNum;//페이지 번호
	protected int amount;//한 페이지당 보여줄 갯수
	
	private String type;//검색할 컬럼명
	private String keyword;// 검색어
	
	public Criteria() {
		this(1, 10);
	}

	public Criteria(int pageNum, int amount) {
		super();
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public int getPaging() {
		return (this.pageNum - 1) * this.amount;
	}
	/**
	 * 
	 * @return
	 */
	public String[] getTypeArr() {
		return type== null?new String[] {} : type.split("");
	}
	
	//?pageNum=1&amount=10&type=T&keyword=한글
	public String getListLink() {
		UriComponentsBuilder builder 
				= UriComponentsBuilder.fromPath("")
					.queryParam("pageNum", this.pageNum)
					.queryParam("amount", this.amount)
					.queryParam("type", this.type)
					.queryParam("keyword", this.keyword)
					.queryParam("boardId", this.boardId);
		
		return builder.toUriString();
	}
	
	//?pageNum=1&amount=10&type=&keyword=&bno=475033
	//?pageNum=1&amount=10&type=T&keyword=한글&bno=글번호
	public String getGetLink() {
		UriComponentsBuilder builder 
				= UriComponentsBuilder.fromPath("")
					.queryParam("pageNum", this.pageNum)
					.queryParam("amount", this.amount)
					.queryParam("type", this.type)
					.queryParam("keyword", this.keyword)
					.queryParam("boardId", this.boardId)
					.queryParam("bno", this.bno);
		
		return builder.toUriString();
	}
}
