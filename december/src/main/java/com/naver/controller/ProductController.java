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

import com.naver.domain.ProductCriteria;
import com.naver.domain.ProductVO;
import com.naver.domain.PageDTO;
import com.naver.service.ProductService;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/admin/product/*")
@AllArgsConstructor
public class ProductController {

	private ProductService service;
	@PostMapping("/get")
	public String get(MultipartFile pImg, ProductVO product,
				@RequestParam("oriProductImg") String oriProductImg, RedirectAttributes rttr) {
		//첨부이미지 처리
		//첨부된 파일이 없으면
		if(oriProductImg.isEmpty()) {			
			product.setProductImg(oriProductImg);
		} else {
			//첨부된 파일이 있으면
			
			String uploadFolder = "d:/upload";
			
			//기본파일삭제
			File delFile = new File(uploadFolder, oriProductImg);
			if(delFile.exists()) {
				delFile.delete();
			}
			// 끝
			String uploadFolderPath = getFolder();
			
			File uploadPath = new File(uploadFolder, getFolder());
			
			if(uploadPath.exists() == false) {
				uploadPath.mkdirs();
			}
					
			String uploadFileName = pImg.getOriginalFilename();
					
			UUID uuid = UUID.randomUUID();
			
			uploadFileName = uuid.toString() + "_" + pImg.getOriginalFilename();
			
			File saveFile = new File(uploadPath, uploadFileName);
			
			try {
				pImg.transferTo(saveFile);
							
			} catch (Exception e) {
				e.printStackTrace();
			}
				
			String pfImgPath = uploadFolderPath + "/" + uploadFileName;
			
			product.setProductImg(pfImgPath);
		}
		
		//첨부이미지 처리 끝
	

		service.modify(product);
		
			
		return "redirect:list"; 
	}
	
	
	@GetMapping("/list")
	
	public void list(Model model, ProductCriteria cri){
		model.addAttribute("list", service.getList(cri));
		long total = service.getTotal(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
		total = (total -((cri.getPageNum()-1)*cri.getAmount()));
		model.addAttribute("total", total);
		model.addAttribute("active", "product");
	}
	@GetMapping("/register")
	public void register(Model model) {
		
		
		model.addAttribute("active", "product");
		
	}
	
	@GetMapping("/get")
	public void get(Model model, @RequestParam("productCode") String productCode) {
		//직장 정보 조회
		model.addAttribute("product", service.get(productCode));
		
		
		model.addAttribute("active", "product");
		
	}
	
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		
		return str.replace("-", File.separator);
	}
	
	
	@PostMapping("/register")
	public String register(MultipartFile pImg, ProductVO product, RedirectAttributes rttr) {
		//제품코드 자동생성
		String productCode = service.getMakePCode();
		product.setProductCode(productCode);
		
		//첨부이미지 처리
		//첨부된 파일이 없으면
		if(!pImg.isEmpty()) {			
			
			String uploadFolder = "d:/upload";
			
			String uploadFolderPath = getFolder();
			
			File uploadPath = new File(uploadFolder, getFolder());
			
			if(uploadPath.exists() == false) {
				uploadPath.mkdirs();
			}
					
			String uploadFileName = pImg.getOriginalFilename();
					
			UUID uuid = UUID.randomUUID();
			
			uploadFileName = uuid.toString() + "_" + pImg.getOriginalFilename();
			
			File saveFile = new File(uploadPath, uploadFileName);
			
			try {
				pImg.transferTo(saveFile);
							
			} catch (Exception e) {
				e.printStackTrace();
			}
				
			String pfImgPath = uploadFolderPath + "/" + uploadFileName;
			
			product.setProductImg(pfImgPath);
		}
		
		//첨부이미지 처리 끝
	

		service.register(product);
		
			
		return "redirect:list";
	}
	
}
