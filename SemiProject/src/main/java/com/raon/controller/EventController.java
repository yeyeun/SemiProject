package com.raon.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;

import javax.servlet.annotation.WebServlet;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.raon.domain.Board;
import com.raon.domain.Course;
import com.raon.domain.Event;
import com.raon.service.BoardService;
import com.raon.service.EventService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
@RequestMapping("/event/*")
public class EventController {
	@Autowired
	private EventService service;
	@Autowired
	private BoardService service2;
	
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
	
	@GetMapping("/listhome")
	public String listhome(Model model) {
		try {			
			service.getList(model);

			List<Board> boards = service2.getList(); // 서비스에서 리스트를 가져옴

			// bno 속성을 기준으로 내림차순으로 정렬
			boards.sort(Comparator.comparing(Board::getBno).reversed());

			// 처음부터 5개의 요소를 추출하여 selectedBoards 리스트에 저장
			List<Board> selectedBoards = boards.subList(0, Math.min(6, boards.size()));
			
			
			List<Event> temp = (List<Event>) model.getAttribute("eventList");
			Collections.shuffle(temp);
			List<Event> selectedEvents = temp.subList(0, Math.min(5, temp.size()));
			log.info("controller -> list success");
			model.addAttribute("selectedBoards",selectedBoards);
			model.addAttribute("selectedEvents",selectedEvents);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			log.info("controller -> list fail");
		}
		
		return "home/boardBanner";
	}
	@GetMapping("/detail")
	public String detail(@RequestParam("contentId") String contentId, Model model) {
		log.info("controller -> detail success"+contentId);
        try {
			log.info("controller -> Detail success");
	       	service.getDetailImage(contentId, model);
	       	service.getDetailInfo(contentId, model);
	       	service.detailCommon(contentId, model);
	       	service.detailIntro(contentId, model);	       	

		} catch (IOException e) {
			// TODO Auto-generated catch block
			log.info("controller -> Detail fail");		
			e.printStackTrace();
		}
		return "event/event_detail";		
	}
}
