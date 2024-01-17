package com.naver.controller;

import java.security.Principal;
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
import com.naver.domain.DiaryVO;
import com.naver.service.DiaryService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@AllArgsConstructor
@RequestMapping("/admin/diaries/")
public class DiaryController {

	private DiaryService service;
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/new", consumes = "application/json")
	public ResponseEntity<String> create(Principal principal, @RequestBody DiaryVO vo){
		
		vo.setWriter(principal.getName());
		
		int insertCount = service.register(vo);
		
		return insertCount == 1 
				? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/month")
	public ResponseEntity<List<DiaryVO>> getList(){
		
		return new ResponseEntity<List<DiaryVO>>(service.getListPage(), HttpStatus.OK);
	}
	
	@GetMapping(value = "/{dno}")
	public ResponseEntity<DiaryVO> get(@PathVariable("dno") Long dno){
		return new ResponseEntity<DiaryVO> (service.get(dno), HttpStatus.OK);
	}
	
	@RequestMapping(value = "/{dno}",
			method = {RequestMethod.PUT, RequestMethod.PATCH},			
			consumes = "application/json")
	public ResponseEntity<String> modify(@RequestBody DiaryVO vo, 
											@PathVariable("dno") Long dno){
		System.out.println(vo);
		vo.setDno(dno);
		return service.modify(vo) == 1
				? new ResponseEntity<> ("success", HttpStatus.OK)
				: new ResponseEntity<> (HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@DeleteMapping(value="/{dno}")
	public ResponseEntity<String> remove(@PathVariable("dno") Long dno, 
											@RequestBody DiaryVO vo){
		return service.remove(dno) == 1
				? new ResponseEntity<> ("success", HttpStatus.OK)
				: new ResponseEntity<> (HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
