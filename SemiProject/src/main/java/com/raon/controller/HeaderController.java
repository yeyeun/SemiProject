package com.raon.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.raon.domain.Board;
import com.raon.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/header/*")
@AllArgsConstructor
public class HeaderController {
	
	@GetMapping("/main")
	public String main() {
		log.info("main");
		return "home/main";
	}
	@GetMapping("/tour")
	public String tour() { //Model: 데이터를 담고 있는 객체
		log.info("tour");
		return "tour/tour";
	}	
	@GetMapping("/course")
	public String course() { //Model: 데이터를 담고 있는 객체
		log.info("course");
		return "course/course_main";
	}	
	@GetMapping("/event")
	public String event() { //Model: 데이터를 담고 있는 객체
		log.info("event");
		return "event/event_main";
	}	
	@GetMapping("/board")
	public String board() { //Model: 데이터를 담고 있는 객체
		log.info("board");
		return "board/list";
	}	
	@GetMapping("/login")
	public String login() { //Model: 데이터를 담고 있는 객체
		log.info("login");
		return "login/login";
	}	
}
