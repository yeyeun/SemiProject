package com.raon.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.annotation.WebServlet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.raon.domain.Event;
import com.raon.service.EventService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
@RequestMapping("/event/*")
public class EventController {
	private EventService service;
	
	@GetMapping("/list")
	public String list(Model model) {
		try {
			
			service.getList(model);
			log.info("controller -> list success");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			log.info("controller -> list fail");
		}
		
		return "event/event_main";
	}

}
