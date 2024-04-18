package com.raon.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mysql.cj.Session;
import com.raon.domain.Cart;
import com.raon.domain.Members;
import com.raon.domain.Mytourpage;
import com.raon.domain.TourDetailInfo;
import com.raon.service.MemberService;
import com.raon.service.MypageService;
import com.raon.service.TourService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/mypage/*")
@AllArgsConstructor
public class MypageController {
	private MypageService mypageservice;
	private MemberService memberService;

	@GetMapping("/mypage")
	public String mypage() {
		log.info("mypage");
		return "mypage/mypage";
	}

	@GetMapping("/myprofile")
	public String myprofile(HttpSession session, Model model) {
		log.info("myprofile");
		String id = (String) session.getAttribute("loginId");
		Members member = memberService.getMemberById(id);
		model.addAttribute("member", member);
		return "mypage/myprofile";
	}
	
	@GetMapping("/updateprofile")
	public String updateprofile(HttpSession session, Model model,Members member) {
		log.info("myprofile");
		memberService.updateMember(member);
		model.addAttribute("member", member);
		return "redirect:/mypage/mypage";
	}

	@GetMapping("/mywrite")
	public String mywrite() {
		log.info("mywrite");
		return "mypage/mywrite";
	}

	@GetMapping("/mytour")
	public String mytour(HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {
		String loginId = (String) request.getSession().getAttribute("loginId");
		model.addAttribute("mytourList", mypageservice.read(loginId));
		mypageservice.getTourDetail(request, response, model);

		return "mypage/mytour";
	}
}
