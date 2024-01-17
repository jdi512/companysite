package com.naver.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;
import java.util.List;

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

import com.naver.domain.LogVO;
import com.naver.domain.Criteria;
import com.naver.domain.PageDTO;
import com.naver.service.LogService;
import com.naver.service.MemberService;
import com.naver.domain.MemberVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/log/*")
@AllArgsConstructor
public class LogController {
	
	private LogService service;
	private MemberService memberService;
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		model.addAttribute("list", service.getList(cri));
		
		int total = service.getTotal(cri);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));

		//페이지별 시작번호
		total = (total -((cri.getPageNum()-1)*cri.getAmount()))+1;
		
		model.addAttribute("total", total);
		model.addAttribute("active", "log");
	}
	
	/**
	 * 목록에서 에이작스로 게시글들 삭제할때
	 * @param cri
	 * @param rttr
	 * @param bnos
	 * @return
	 */
	@PostMapping("/list")
	public String list(Criteria cri, RedirectAttributes rttr, 
							@RequestParam("bno") long[] bnos) {
		
		service.remove(bnos);
	
		return "redirect:/admin/log/list" + cri.getListLink();
	}

	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/register")
	public String register(LogVO log, RedirectAttributes rttr, Principal principal) {
		
		log.setWriter(principal.getName());
		
		service.register(log);
		
		rttr.addFlashAttribute("result", log.getBno());
		return "redirect:/admin/log/list";
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/register")
	public void register(Model model) {
		model.addAttribute("active", "log");
	}
	
	
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("bno") Long bno, 
				@ModelAttribute("cri") Criteria cri, Model model) {
		LogVO vo = service.get(bno);
		MemberVO mvo = memberService.modify(vo.getWriter());
		
		model.addAttribute("log", vo);
		model.addAttribute("member", mvo);
		model.addAttribute("active", "log");
	}
	
	@PreAuthorize("principal.username == #log.writer")
	@PostMapping("/modify")
	public String modify(LogVO log, 
				@ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		
		if(service.modify(log)) {
			rttr.addFlashAttribute("result", "success");
		}
			
		return "redirect:/admin/log/get" + cri.getGetLink();
	}
	
	/**
	 * 게시글 삭제
	 * @param bno
	 * @param cri
	 * @param rttr
	 * @return
	 */
	@PostMapping("/remove")
	@PreAuthorize("principal.username == #writer")
	public String remove(@RequestParam("bno") Long bno, 
				@ModelAttribute("cri") Criteria cri, RedirectAttributes rttr, String writer) {
		
		
		//데이터베이스상에서 해당 게시물과 첨부파일 데이터 삭제
		if(service.remove(bno)) {
			
			rttr.addFlashAttribute("result", "success");
		}
		
		
		return "redirect:/admin/log/list" + cri.getListLink();
	}


	/**
	 * 글목록에서 에이작스로 삭제함
	 * @param bno
	 * @return
	 */
	@DeleteMapping(value="/{bno}")
	public ResponseEntity<String> remove(@PathVariable("bno") Long bno){
		return service.remove(bno)
				? new ResponseEntity<> ("success", HttpStatus.OK)
				: new ResponseEntity<> (HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
}
