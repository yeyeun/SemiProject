package com.raon.controller;

import com.raon.domain.Members;
import com.raon.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/member")
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
        return "redirect:/front/main.jsp";
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
        return "redirect:/front/main.jsp";
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @PostMapping("/login")
    public String login(HttpSession session, @RequestParam String id, @RequestParam String pwd) {
        if (memberService.isUser(id, pwd)) {
            session.setAttribute("loginId", id);
            return "redirect:/front/main.jsp";
        } else {
            return "redirect:/login/login.jsp";
        }
    }

    @PostMapping("/signUp")
    public String signUp(Members member) {
        memberService.registerMember(member);
        return "redirect:/login/login.jsp";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}
