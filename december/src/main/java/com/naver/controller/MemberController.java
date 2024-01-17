package com.naver.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.naver.domain.AttachFileDTO;
import com.naver.domain.MemberCriteria;
import com.naver.domain.MemberPageDTO;
import com.naver.service.MemberService;
import com.naver.domain.AuthVO;
import com.naver.domain.MemberVO;

import lombok.AllArgsConstructor;
import lombok.Setter;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@RequestMapping("/admin/member/*")
@AllArgsConstructor
public class MemberController {

	private PasswordEncoder pwencoder;

	private MemberService service;

	@PreAuthorize("isAuthenticated()")
	@GetMapping("/list")
	public void list(MemberCriteria cri, Model model) {
		model.addAttribute("list", service.getList(cri));

		int total = service.getTotal(cri);

		model.addAttribute("pageMaker", new MemberPageDTO(cri, total));

		// 페이지별 시작번호
		total = (total - ((cri.getPageNum() - 1) * cri.getAmount())) + 1;

		model.addAttribute("total", total);
		model.addAttribute("active", "member");
	}

	@GetMapping("/modify")
	public void modify(@RequestParam("userid") String userid, 
			@ModelAttribute("cri") MemberCriteria cri, Model model) {
		
		model.addAttribute("member", service.modify(userid));
		model.addAttribute("active", "member");
	
	}
	
	@PostMapping("/modify")
	public String modify(MultipartFile profileImg,
				@RequestParam("oriPfImg") String oriPfImg, MemberVO member, String [] auth, 
				@ModelAttribute("cri") MemberCriteria cri, RedirectAttributes rttr) {
		//첨부이미지 처리
		//첨부된 파일이 없으면
		if(profileImg.isEmpty()) {			
			member.setPfImg(oriPfImg);
		} else {
			//첨부된 파일이 있으면
			
			String uploadFolder = "d:/upload";
			
			//기본파일삭제
			File delFile = new File(uploadFolder, oriPfImg);
			if(delFile.exists()) {
				delFile.delete();
			}
			// 끝
			String uploadFolderPath = getFolder();
			
			File uploadPath = new File(uploadFolder, getFolder());
			
			if(uploadPath.exists() == false) {
				uploadPath.mkdirs();
			}
					
			String uploadFileName = profileImg.getOriginalFilename();
					
			UUID uuid = UUID.randomUUID();
			
			uploadFileName = uuid.toString() + "_" + profileImg.getOriginalFilename();
			
			File saveFile = new File(uploadPath, uploadFileName);
			
			try {
				profileImg.transferTo(saveFile);
							
			} catch (Exception e) {
				e.printStackTrace();
			}
				
			String pfImgPath = uploadFolderPath + "/" + uploadFileName;
			
			member.setPfImg(pfImgPath);
		}
		
		//첨부이미지 처리 끝
		
		//회원정보수정
		List<AuthVO> list = new ArrayList<>();

		if(auth != null) {
			for(int i = 0; i < auth.length; i++) {
				AuthVO vo = new AuthVO();
				vo.setUserid(member.getUserid());
				vo.setAuth(auth[i]);
				
				list.add(vo);
	
			}
		}
		
		member.setAuthList(list);

		service.modify(member);
		
			
		return "redirect:/admin/member/modify" + cri.getGetLink();
	}
	
	@GetMapping("/register")
	public void register(Model model) {
		model.addAttribute("active", "member");
	}
	
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		
		return str.replace("-", File.separator);
	}
	
	@PostMapping("/register")
	public String register(MultipartFile profileImg, MemberVO member, String [] auth, RedirectAttributes rttr) {
		//프로필사진등록
		String uploadFolder = "d:/upload";

		String uploadFolderPath = getFolder();
		
		File uploadPath = new File(uploadFolder, getFolder());
		
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
				
		String uploadFileName = profileImg.getOriginalFilename();
				
		UUID uuid = UUID.randomUUID();
		
		uploadFileName = uuid.toString() + "_" + profileImg.getOriginalFilename();
		
		File saveFile = new File(uploadPath, uploadFileName);
		
		try {
			profileImg.transferTo(saveFile);
						
		} catch (Exception e) {
			e.printStackTrace();
		}
			
		String pfImgPath = uploadFolderPath + "/" + uploadFileName;
		
		//End
		//회원정보등록
		
		member.setPfImg(pfImgPath);
		
		String userpw = pwencoder.encode(member.getUserpw());
		member.setUserpw(userpw);
		
		List<AuthVO> list = new ArrayList<>();

		if(auth != null) {
			for(int i = 0; i < auth.length; i++) {
				AuthVO vo = new AuthVO();
				vo.setUserid(member.getUserid());
				vo.setAuth(auth[i]);
				
				list.add(vo);
	
			}
		}
		
		member.setAuthList(list);
		
		service.register(member);
		
		return "redirect:/admin/member/list";
	}

	@PostMapping(value = "/{userid}")
	public ResponseEntity<String> idDuplicateChk(@PathVariable("userid") String userid){
		MemberVO member = service.idDuplicateChk(userid);
		
		return member != null
				? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>("fail", HttpStatus.OK);
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("userid") String userid, MemberCriteria cri, 
															RedirectAttributes rttr) {
		if(service.remove(userid)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/admin/member/list" + cri.getListLink();
	}
	
	@GetMapping("/myPage")
	public void myPage(Principal principal, Model model) {
		String userid = principal.getName();
		model.addAttribute("member", service.modify(userid));
		model.addAttribute("active", "mypage");
	}
	
}
