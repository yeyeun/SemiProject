package com.raon.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/home")
public class HomeController {

	
	@GetMapping("/")
	public String home() {
		
		return "home/main";
	}
	
	@GetMapping("/mypage")
	public String mypage() {
		
		return "mypage/mypage";
	}
	
	
}
