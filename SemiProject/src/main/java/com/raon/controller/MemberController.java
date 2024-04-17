package com.raon.controller;

import com.raon.domain.Members;
import com.raon.service.BoardService;
import com.raon.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@Log4j
@RequestMapping("/login/*")
@AllArgsConstructor
public class MemberController {

    @Autowired
    private MemberService memberService;

    @GetMapping("/list")
    public String list(Model model) {
        List<Members> memberList = memberService.getAllMembers();
        model.addAttribute("memberList", memberList);
        return "member/memberList";
    }

    @GetMapping("/read")
    public String read(@RequestParam("id") String id, Model model) {
        Members member = memberService.getMemberById(id);
        model.addAttribute("member", member);
        return "member/read";
    }

    @GetMapping("/updateFrm")
    public String updateForm(HttpSession session, Model model) {
        String loginId = (String) session.getAttribute("loginId");
        Members member = memberService.getMemberById(loginId);
        model.addAttribute("member", member);
        return "member/updateFrm";
    }

    @PostMapping("/update")
    public String update(Members member) {
        memberService.updateMember(member);
        return "redirect:/header/main";
    }

    @PostMapping("/delete")
    public String delete(HttpSession session) {
        String loginId = (String) session.getAttribute("loginId");
        memberService.deleteMember(loginId);
        return "redirect:/member/list";
    }

    @GetMapping("/rePwd")
    public String rePwd(HttpSession session, Model model) {
        String loginId = (String) session.getAttribute("loginId");
        Members member = memberService.getMemberById(loginId);
        model.addAttribute("member", member);
        return "rePwd";
    }

    @PostMapping("/updatePwd")
    public String updatePwd(Members member) {
        memberService.updatePassword(member);
        return "redirect:home/main";
    }

    @GetMapping("/login")
    public String login() {
        return "login/login";
    }
   
    
    @PostMapping("/login")
    public String login(HttpSession session, @RequestParam String id, @RequestParam String pwd) {
        if (memberService.isUser(id, pwd)) {
        	log.info("login....");
            session.setAttribute("loginId", id);
            return "redirect:/header/main";
        } else {
            return "redirect:/login/login";
        }
    }

    @PostMapping("/signUp")
    public String signUp(Members member) {
    	log.info("signUp...");
        memberService.registerMember(member);
        return "redirect:/login/login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
  //Id 중복 확인
  	@PostMapping("/ConfirmId")
  	@ResponseBody
  	public ResponseEntity<Boolean> confirmId(String id) {
  		log.info("ConfirmId.........");
  		log.info("id : " + id);
  		boolean result = true;
  		
  		if(id.trim().isEmpty()) {
  			log.info("id : " + id);
  			result = false;
  		} else {
  			if (memberService.selectId(id)) {
  				result = false;
  			} else {
  				result = true;
  			}
  		}
  		
  		return new ResponseEntity<>(result, HttpStatus.OK);
  	}
}
