package com.naver.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.naver.domain.AttachVO;
import com.naver.domain.AdminBoardVO;
import com.naver.domain.Criteria;
import com.naver.domain.PageDTO;
import com.naver.service.AdminBoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/board/*")
@AllArgsConstructor
public class AdminBoardController {
	
	private AdminBoardService service;
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		
		model.addAttribute("list", service.getList(cri));
		
		int total = service.getTotal(cri);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));

		//페이지별 시작번호
		total = (total -((cri.getPageNum()-1)*cri.getAmount()))+1;
		
		model.addAttribute("total", total);
		
		model.addAttribute("active", "board");
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/gallery")
	public void gallery(Criteria cri, Model model) {
		model.addAttribute("list", service.getGallery(cri));
		
		int total = service.getTotal(cri);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));

		//페이지별 시작번호
		total = (total -((cri.getPageNum()-1)*cri.getAmount()))+1;
		
		model.addAttribute("total", total);
		model.addAttribute("active", "board");
	}
	
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/register")
	public String register(AdminBoardVO board, Principal principal) {
		
		board.setWriter(principal.getName());
		
		
		service.register(board);
		
		return "redirect:/admin/board/list";
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/register")
	public void register(Model model) {
		model.addAttribute("active", "board");
	}
	
	
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("bno") Long bno, 
				@ModelAttribute("cri") Criteria cri, Model model) {
		model.addAttribute("board", service.get(bno));
		model.addAttribute("active", "board");
	}
	
	@PostMapping("/modify")
	public String modify(AdminBoardVO board, 
				@ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		
		if(service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
			
		return "redirect:/admin/board/get" + cri.getGetLink();
	}
	
	/**
	 * 게시글 삭제
	 * @param bno
	 * @param cri
	 * @param rttr
	 * @return
	 */
	@PostMapping("/remove")
	public String remove(AdminBoardVO board, 
				@ModelAttribute("cri") Criteria cri, RedirectAttributes rttr, String writer) {
		
		//데이터베이스상에서 해당 게시물과 첨부파일 데이터 삭제
		if(service.remove(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		
		return "redirect:/admin/board/list" + cri.getListLink();
	}

	
	@PostMapping(value = "/{tableName}")
	public ResponseEntity<String> existTable(@PathVariable("tableName") String tableName){
		int count = service.existTable(tableName);
		
		return count == 1
				? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>("fail", HttpStatus.OK);
	}
	
	
}
