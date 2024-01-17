package com.naver.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.naver.domain.CompanyCriteria;
import com.naver.domain.CompanyVO;
import com.naver.domain.PageDTO;
import com.naver.service.CompanyService;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/admin/company/*")
@AllArgsConstructor
public class CompanyController {

	private CompanyService service;
	@PostMapping("/get")
	public String get(MultipartFile compSeal, CompanyVO company,
				@RequestParam("oriCompanySeal") String oriCompanySeal, RedirectAttributes rttr) {
		//첨부이미지 처리
		//첨부된 파일이 없으면
		if(oriCompanySeal.isEmpty()) {			
			company.setCompanySeal(oriCompanySeal);
		} else {
			//첨부된 파일이 있으면
			
			String uploadFolder = "d:/upload";
			
			//기본파일삭제
			File delFile = new File(uploadFolder, oriCompanySeal);
			if(delFile.exists()) {
				delFile.delete();
			}
			// 끝
			String uploadFolderPath = getFolder();
			
			File uploadPath = new File(uploadFolder, getFolder());
			
			if(uploadPath.exists() == false) {
				uploadPath.mkdirs();
			}
					
			String uploadFileName = compSeal.getOriginalFilename();
					
			UUID uuid = UUID.randomUUID();
			
			uploadFileName = uuid.toString() + "_" + compSeal.getOriginalFilename();
			
			File saveFile = new File(uploadPath, uploadFileName);
			
			try {
				compSeal.transferTo(saveFile);
							
			} catch (Exception e) {
				e.printStackTrace();
			}
				
			String pfImgPath = uploadFolderPath + "/" + uploadFileName;
			
			company.setCompanySeal(pfImgPath);
		}
		
		//첨부이미지 처리 끝
	

		service.modify(company);
		
			
		return "redirect:list"; 
	}
	
	
	@GetMapping("/list")
	
	public void list(Model model, CompanyCriteria cri){
		model.addAttribute("list", service.getList(cri));
		long total = service.getTotal(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
		total = (total -((cri.getPageNum()-1)*cri.getAmount()));
		model.addAttribute("total", total);
		model.addAttribute("active", "company");
	}
	@GetMapping("/register")
	public void register(Model model) {
		
		model.addAttribute("bizTypes", service.getBizType());
		
		model.addAttribute("active", "company");
		
	}
	@GetMapping("/myCompany")
	public void myCompany(Model model) {
		String ourCompanyName = "경북직업전문학교";
		//직장 정보 조회
		model.addAttribute("company", service.get(ourCompanyName));
		
		model.addAttribute("bizTypes", service.getBizType());
		
		model.addAttribute("active", "myCompany");
		
	}
	
	@GetMapping("/get")
	public void get(Model model, @RequestParam("compName") String companyName) {
		//직장 정보 조회
		model.addAttribute("company", service.get(companyName));
		
		model.addAttribute("bizTypes", service.getBizType());
		
		model.addAttribute("active", "company");
		
	}
	
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		
		return str.replace("-", File.separator);
	}
	@PostMapping("/myCompany")
	public String modify(MultipartFile compSeal, CompanyVO company,
				@RequestParam("oriCompanySeal") String oriCompanySeal, RedirectAttributes rttr) {
		//첨부이미지 처리
		//첨부된 파일이 없으면
		if(oriCompanySeal.isEmpty()) {			
			company.setCompanySeal(oriCompanySeal);
		} else {
			//첨부된 파일이 있으면
			
			String uploadFolder = "d:/upload";
			
			//기본파일삭제
			File delFile = new File(uploadFolder, oriCompanySeal);
			if(delFile.exists()) {
				delFile.delete();
			}
			// 끝
			String uploadFolderPath = getFolder();
			
			File uploadPath = new File(uploadFolder, getFolder());
			
			if(uploadPath.exists() == false) {
				uploadPath.mkdirs();
			}
					
			String uploadFileName = compSeal.getOriginalFilename();
					
			UUID uuid = UUID.randomUUID();
			
			uploadFileName = uuid.toString() + "_" + compSeal.getOriginalFilename();
			
			File saveFile = new File(uploadPath, uploadFileName);
			
			try {
				compSeal.transferTo(saveFile);
							
			} catch (Exception e) {
				e.printStackTrace();
			}
				
			String pfImgPath = uploadFolderPath + "/" + uploadFileName;
			
			company.setCompanySeal(pfImgPath);
		}
		
		//첨부이미지 처리 끝
	

		service.modify(company);
		
			
		return "redirect:myCompany";
	}
	
	@PostMapping("/register")
	public String register(MultipartFile compSeal, CompanyVO company, RedirectAttributes rttr) {
		//첨부이미지 처리
		//첨부된 파일이 없으면
		if(!compSeal.isEmpty()) {			
			
			String uploadFolder = "d:/upload";
			
			String uploadFolderPath = getFolder();
			
			File uploadPath = new File(uploadFolder, getFolder());
			
			if(uploadPath.exists() == false) {
				uploadPath.mkdirs();
			}
					
			String uploadFileName = compSeal.getOriginalFilename();
					
			UUID uuid = UUID.randomUUID();
			
			uploadFileName = uuid.toString() + "_" + compSeal.getOriginalFilename();
			
			File saveFile = new File(uploadPath, uploadFileName);
			
			try {
				compSeal.transferTo(saveFile);
							
			} catch (Exception e) {
				e.printStackTrace();
			}
				
			String pfImgPath = uploadFolderPath + "/" + uploadFileName;
			
			company.setCompanySeal(pfImgPath);
		}
		
		//첨부이미지 처리 끝
	

		service.register(company);
		
			
		return "redirect:list";
	}
	
}
