package com.naver.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.naver.domain.Criteria;


import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/*")
@AllArgsConstructor
public class AdminController {

	
	@GetMapping("/")
	public String dashboard(Model model, Criteria cri) {
		
		
		model.addAttribute("active", "dashboard");
		return "admin/dashboard";
	}
	
}
