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
import com.naver.domain.AttachVO;
import com.naver.domain.BoardVO;
import com.naver.domain.Criteria;
import com.naver.domain.LogVO;
import com.naver.domain.MemberVO;
import com.naver.domain.PageDTO;
import com.naver.domain.ReplyPageDTO;
import com.naver.domain.ReplyVO;
import com.naver.service.AdminBoardService;
import com.naver.service.BoardService;
import com.naver.service.MemberService;
import com.naver.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {
	
	private BoardService service;
	private AdminBoardService adminService;
	private MemberService memberService;
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		
		if(cri.getBoardId() == null || "".equals(cri.getBoardId())) {
			model.addAttribute("error", "OK");
			return;
		}
		
		//게시판정보가져오기 AdminBoard
		model.addAttribute("boardInfo", adminService.getBoardInfo(cri.getBoardId()));
		
		model.addAttribute("list", service.getList(cri));
		
		int total = service.getTotal(cri);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));

		//페이지별 시작번호
		total = (total -((cri.getPageNum()-1)*cri.getAmount()))+1;
		
		model.addAttribute("total", total);
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
	}
	
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr, Principal principal) {
		
		board.setWriter(principal.getName());
		
		service.register(board);
		
		rttr.addFlashAttribute("result", board.getBno());
		return "redirect:/board/list?boardId=" + board.getBoardId();
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/register")
	public void register(BoardVO board, Model model) {
		//게시판정보가져오기 AdminBoard
		model.addAttribute("boardInfo", adminService.getBoardInfo(board.getBoardId()));
	}
	
	
	@GetMapping({"/get", "/modify"})
	public void get(BoardVO board, 
				@ModelAttribute("cri") Criteria cri, Model model) {
		BoardVO vo = service.get(board);
		MemberVO mvo = memberService.modify(vo.getWriter());
		//작성자의 직책/이메일 등을 가져오기
		model.addAttribute("member", mvo);
		//게시판정보가져오기 AdminBoard
		model.addAttribute("boardInfo", adminService.getBoardInfo(board.getBoardId()));
		
		model.addAttribute("board", service.get(board));
	}
	
	@PreAuthorize("principal.username == #board.writer")
	@PostMapping("/modify")
	public String modify(BoardVO board, 
				@ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		
		if(service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
			
		return "redirect:/board/get" + cri.getGetLink();
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
	public String remove(BoardVO board, 
				@ModelAttribute("cri") Criteria cri, RedirectAttributes rttr, String writer) {
		//해당 게시물의 첨부파일 정보를 미리 준비
		List<AttachVO> attachList = service.getAttachList(board);
		
		//데이터베이스상에서 해당 게시물과 첨부파일 데이터 삭제
		if(service.remove(board)) {

			//첨부파일 목록을 이용해서 해당폴더에서 파일 삭제		
			deleteFiles(attachList);
			
			rttr.addFlashAttribute("result", "success");
		}
		
		
		return "redirect:/board/list" + cri.getListLink();
	}
	
	/**
	 * 파일 삭제
	 * @param vo
	 * @return
	 */
	
	private void deleteFiles(List<AttachVO> attachList) {
		if(attachList == null || attachList.size() == 0 ) {
			return;
		}
		
		attachList.forEach(attach -> {
			Path file = Paths.get("d:/upload/" + attach.getUploadPath() + "/" + attach.getUuid() + "_" + attach.getFileName());
			
			try {
				Files.deleteIfExists(file);
				
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbNail = Paths.get("d:/upload/" + attach.getUploadPath() + "/s_" + attach.getUuid() + "_" + attach.getFileName());
					
					Files.delete(thumbNail);
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		});
	}

	

	@PostMapping(value = "/new", consumes = "application/json")
	public ResponseEntity<String> create(@RequestBody BoardVO vo){
		int insertCount = service.registerTmp(vo);
		
		return insertCount == 1 
				? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
	@GetMapping(value = "/pages")
	public ResponseEntity<List<BoardVO>> getTmpList(BoardVO board){

		return new ResponseEntity<List<BoardVO>>(service.getTmpList(board), HttpStatus.OK);
	}
	
//	@GetMapping(value = "/{bno}")
//	public ResponseEntity<BoardVO> get(@PathVariable("bno") Long bno){
//		return new ResponseEntity<BoardVO> (service.get(bno), HttpStatus.OK);
//	}
	
	
	
	@GetMapping(value = "/getAttachList")
	@ResponseBody
	public ResponseEntity<List<AttachVO>> getAttachList(BoardVO board){
		return new ResponseEntity<List<AttachVO>>(service.getAttachList(board), HttpStatus.OK);
	}
	
}
