package com.raon.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/mypage/*")
@AllArgsConstructor
public class MypageController {
	
	@GetMapping("/mypage")
	public String mypage() {
		log.info("mypage");
		return "mypage/mypage";
	}
	
	@GetMapping("/myprofile")
	public String myprofile() {
		log.info("myprofile");
		return "mypage/myprofile";
	}
	
	@GetMapping("/mywrite")
	public String mywrite() {
		log.info("mywrite");
		return "mypage/mywrite";
	}
	
	@GetMapping("/mytour")
	public String mytour() {
		log.info("mytour");
		return "mypage/mytour";
	}
}
