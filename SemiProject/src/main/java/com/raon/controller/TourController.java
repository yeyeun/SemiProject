package com.raon.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.raon.service.TourService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
@RequestMapping("/tour/*")
public class TourController {
	private TourService service;
	
	@GetMapping("/list")
	public String list(Model model,  @RequestParam(defaultValue = "1") int page) {
		try {
			service.getTourList(model, page);
			log.info("controller -> list success");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			log.info("controller -> list fail");
		}
		
		return "tour/tour";
	}
	
	@GetMapping("/detail")
	public String detail(HttpServletRequest request, HttpServletResponse response, Model model) {
		try {
			service.getTourDetail(request, response, model);
			log.info("controller -> detail success");
			//service.getTourImage(request, response, model);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			log.info("controller -> detail fail");
		}
		
		return "tour/tour_detail";
	}


}
