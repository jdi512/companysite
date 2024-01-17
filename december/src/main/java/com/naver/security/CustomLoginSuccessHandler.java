package com.naver.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication auth) throws IOException, ServletException {
		
		List<String > roleNames = new ArrayList<>();
		
		//로그인 > 인증 성공 > 권한(ROLE)을 가져옴.
		
		auth.getAuthorities().forEach(authority -> {
			roleNames.add(authority.getAuthority());
		});
		
		//컬렉션(List)에 ROLE_ADMIN 이 포함되어 있으면
		if(roleNames.contains("ROLE_ADMIN")) {
			response.sendRedirect("/admin/");
			return;
		}
		
		//
		response.sendRedirect("/");
		
	}

}
