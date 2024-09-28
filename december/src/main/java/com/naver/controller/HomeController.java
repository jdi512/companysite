package com.naver.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.naver.domain.Criteria;
import com.naver.domain.PageDTO;
import com.naver.service.AdminBoardService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	private AdminBoardService service;
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
	
		return "board/index";
	}
	@GetMapping("/about")
	public String about() {
	
		return "board/about";
	}
	
	@GetMapping("/introduce")
	public String introduce() {
	
		return "board/introduce";
	}
	
	@GetMapping("/login")
	public String login() {
		return "/customLogin";
	}
	@GetMapping("/logout")
	public String logout() {
		return "/customLogout";
	}
	
	
}
