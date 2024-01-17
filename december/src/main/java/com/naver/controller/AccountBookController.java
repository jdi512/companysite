package com.naver.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/accountbook/*")
public class AccountBookController {

	@GetMapping("/diary")
	public void diary(Model model) {
		model.addAttribute("active", "diary");
	}
	
}
