package com.naver.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.naver.domain.MasterCriteria;
import com.naver.domain.MasterVO;
import com.naver.domain.PageDTO;
import com.naver.service.MasterService;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/admin/master/*")
@AllArgsConstructor
public class MasterController {
	
	private MasterService service;
	@GetMapping("/list")
	public void list(Model model, MasterCriteria cri) {
		model.addAttribute("list", service.getListWithPaging(cri));
		long total = service.getTotalCount(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	
		total = (total -((cri.getPageNum()-1)*cri.getAmount()));
		model.addAttribute("total", total);
		model.addAttribute("active", "master");
	}
	@GetMapping(value = "/codes/{SubCode}")
	public ResponseEntity<List<MasterVO>> getList(@PathVariable("SubCode") int SubCode){
		return new ResponseEntity<List<MasterVO>>(service.getBizItems(SubCode), HttpStatus.OK);
		
	}
	 
}
