package com.raon.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.raon.sample.SampleDTO;

import lombok.extern.log4j.Log4j;


@Controller
@Log4j
@RequestMapping("/sample/*")
public class SampleController {
	@RequestMapping("/test") /* /WEB-INF/views/sample/test.jsp */
	public void test() {
		log.info("testing...........");
	}

	@GetMapping("/ex01") /* /WEB-INF/views/ex01.jsp */
	public String ex01(SampleDTO dto) {
		log.info(""+dto);
		return "ex01";
	}
	
	@GetMapping("/ex02")
	public String ex02(@RequestParam("name") String name, @RequestParam("age") int age) {
		log.info("name : " + name);
		log.info("age : " + age);
		return "ex02";
	}
}
