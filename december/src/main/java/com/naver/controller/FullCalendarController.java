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
import com.naver.domain.FullCalendarVO;
import com.naver.service.FullCalendarService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@AllArgsConstructor
@RequestMapping("/admin/fullcalendar/")
public class FullCalendarController {

	private FullCalendarService service;
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/new", consumes = "application/json")
	public ResponseEntity<String> create(Principal principal, @RequestBody FullCalendarVO [] vo){
		
		for(int i = 0; i < vo.length; i++) {
			vo[i].setUsername(principal.getName());
			System.out.println(vo[i]);
		}
		
		int insertCount = service.register(vo);
		
		
		return insertCount == 1 ? 
				new ResponseEntity<String>("success", HttpStatus.OK) : 
				new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		 
	}
	
	@GetMapping(value = "/eventData")
	public ResponseEntity<List<FullCalendarVO>> getList(){
		
		return new ResponseEntity<List<FullCalendarVO>>(service.getListPage(), HttpStatus.OK);
	}
	
	@GetMapping(value = "/{id}")
	public ResponseEntity<FullCalendarVO> get(@PathVariable("id") Long id){
		return new ResponseEntity<FullCalendarVO> (service.get(id), HttpStatus.OK);
	}
	
	@RequestMapping(value = "/{id}",
			method = {RequestMethod.PUT, RequestMethod.PATCH},			
			consumes = "application/json")
	public ResponseEntity<String> modify(@RequestBody FullCalendarVO vo, 
											@PathVariable("id") Long id){
		System.out.println(vo);
		vo.setId(id);
		return service.modify(vo) == 1
				? new ResponseEntity<> ("success", HttpStatus.OK)
				: new ResponseEntity<> (HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@DeleteMapping(value="/{id}")
	public ResponseEntity<String> remove(@PathVariable("id") Long id, 
											@RequestBody FullCalendarVO vo){
		return service.remove(id) == 1
				? new ResponseEntity<> ("success", HttpStatus.OK)
				: new ResponseEntity<> (HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
