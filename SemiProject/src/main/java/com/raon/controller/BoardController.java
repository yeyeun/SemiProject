package com.raon.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.raon.domain.Board;
import com.raon.domain.Criteria;
import com.raon.domain.PageDTO;
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
	public void list(Model model, Criteria cri) { //Model: 데이터를 담고 있는 객체
		log.info("list");
		model.addAttribute("bList", service.getListPaging(cri));
		int total = service.getTotal(cri);
		PageDTO dto = new PageDTO(cri,total);
		model.addAttribute("pagingDTO",dto);
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
	public String write(HttpServletRequest request, HttpServletResponse response) throws Exception {
		if(request.getSession().getAttribute("loginId") == null) { //로그인 여부 확인
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인 후 이용해주세요')");
			out.println("location.href='/login/login';");
			//out.println("history.back()");
			out.println("</script>");
			out.flush();
			throw new Exception();
		}
		return "board/write";
	}
	
	@GetMapping("/read")
	public void read(@RequestParam("bno") Integer bno, Model model) {
		log.info("/read");
		model.addAttribute("board", service.read(bno));
	}

	@GetMapping("/modify")
	public void modify(@RequestParam("bno") Integer bno, Model model) {
		log.info("/modify");
		model.addAttribute("board", service.read(bno));
	}
	
	@PostMapping("/modify")
	public String modify(Board board, RedirectAttributes rttr) {
		log.info("modify : " + board);
		if(service.modify(board)) {
			rttr.addFlashAttribute("result","modify");
		}
		return "redirect:/board/list";
	}
	
	@GetMapping("/remove")
	public String remove(@RequestParam("bno") Integer bno, RedirectAttributes rttr) {
		log.info("remove....." + bno);
		if(service.remove(bno) && service.removeComment(bno)) {
			rttr.addFlashAttribute("result","remove");
		}
		return "redirect:/board/list";
	}
	
	//세션 확인용
	@RequestMapping("/sessionTest")
	public void sessionTest(HttpSession session) {
		session.setAttribute("loginId", "user");
		log.info("로그인 세션 설정 완료");
	}
}
