package com.naver.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.naver.domain.MajorCriteria;
import com.naver.domain.PageDTO;
import com.naver.service.MajorService;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/admin/major/*")
@AllArgsConstructor
public class MajorController {
	
	private MajorService service;
	@GetMapping("/list")
	public void list(Model model, MajorCriteria cri) {
		model.addAttribute("list", service.getListWithPaging(cri));
		long total = service.getTotalCount(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	
		total = (total -((cri.getPageNum()-1)*cri.getAmount()));
		model.addAttribute("total", total);
		model.addAttribute("active", "major");
	}
}
