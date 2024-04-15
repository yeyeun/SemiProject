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
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {
	
	private BoardService service;
	
	@GetMapping("/list")
	public void list(Model model) { //Model: 데이터를 담고 있는 객체
		log.info("list");
		model.addAttribute("bList", service.getList());
	}
	
	@PostMapping("/write")
	public String register(Board board, RedirectAttributes rttr, HttpSession session) {
		log.info("write : " + board);
		String writer = (String)session.getAttribute("loginId");
		board.setWriter(writer);
		service.write(board);
		rttr.addFlashAttribute("result", board.getBno());
		return "redirect:/board/list";
	}
	
	@GetMapping("/write")
	public void write() {
		
	}
	
	@GetMapping("/read")
	public void read(@RequestParam("bno") Integer bno, Model model) {
		log.info("/read");
		model.addAttribute("board", service.read(bno));
	}
	
	@PostMapping("/modify")
	public String modify(Board board, RedirectAttributes rttr) {
		log.info("modify : " + board);
		if(service.modify(board)) {
			rttr.addFlashAttribute("result","success");
		}
		return "redirect:/board/list";
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Integer bno, RedirectAttributes rttr) {
		log.info("remove....." + bno);
		if(service.remove(bno)) {
			rttr.addFlashAttribute("result","success");
		}
		return "redirect:/board/list";
	}
	
	//세션 확인용
	@RequestMapping("/sessionTest")
	public void sessionTest(HttpSession session) {
		session.setAttribute("loginId", "kimUser");
		log.info("로그인 세션 설정 완료");
	}
}
