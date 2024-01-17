package com.naver.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import com.naver.domain.Criteria;
import com.naver.domain.ReplyPageDTO;
import com.naver.domain.ReplyVO;
import com.naver.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@AllArgsConstructor
@RequestMapping("/board/replies/")
public class ReplyController {

	private ReplyService service;
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/new", consumes = "application/json")
	public ResponseEntity<String> create(@RequestBody ReplyVO vo){
		
		int insertCount = service.register(vo);
		
		return insertCount == 1 
				? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// "/admin/replies/pages/475112/1"
	@GetMapping(value = "/pages/{bno}/{page}")
	public ResponseEntity<ReplyPageDTO> getList(@PathVariable("page") int page,
														@PathVariable("bno") Long bno){
		Criteria cri = new Criteria(page, 10);
		System.out.println(cri);
		return new ResponseEntity<ReplyPageDTO>(service.getListPage(cri, bno), HttpStatus.OK);
	}
	
	@GetMapping(value = "/{rno}")
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") Long rno){
		return new ResponseEntity<ReplyVO> (service.get(rno), HttpStatus.OK);
	}
	
	@DeleteMapping(value="/{rno}")
	public ResponseEntity<String> remove(@PathVariable("rno") Long rno, 
											@RequestBody ReplyVO vo){
		return service.remove(rno) == 1
				? new ResponseEntity<> ("success", HttpStatus.OK)
				: new ResponseEntity<> (HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@RequestMapping(value = "/{rno}",
			method = {RequestMethod.PUT, RequestMethod.PATCH},			
			consumes = "application/json")
	public ResponseEntity<String> modify(@RequestBody ReplyVO vo, 
											@PathVariable("rno") Long rno){
		vo.setRno(rno);
		return service.modify(vo) == 1
				? new ResponseEntity<> ("success", HttpStatus.OK)
				: new ResponseEntity<> (HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
