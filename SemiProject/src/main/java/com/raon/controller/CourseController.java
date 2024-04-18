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
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.raon.domain.Course;
import com.raon.service.CourseService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
@RequestMapping("/course/*")
public class CourseController {
	private CourseService service;
	
	@GetMapping("/allList")
	public void allList(Model model) {
		List<Course> allList = service.getList(); 
		model.addAttribute("allList",allList);
	}
	
	@GetMapping("/detail")
	public void detail(@RequestParam("contentid") String contentid, Model model) {
		log.info("----course " + contentid + "상세조회----");
		try {
			List<String> list = service.getSubContents(contentid); //해당 코스의 subcontentid값 배열로 받아오기
	       	service.getDetailInfo(list);
		} catch (IOException e) {
			log.info("----course 상세조회 실패----");		
			e.printStackTrace();
		}
	}

	@GetMapping("/write")
	public void wrtie() {
		
	};
	
	@GetMapping("/list")
	public String list(Model model) { // 코드 전체 정보 중 5개만 추출해서 List형식으로 리턴
		log.info("course_list");
		List<Course> courseList = service.getList();
		// contentid가 2717306인 항목을 제외하고 필터링
		List<Course> filteredList = courseList.stream()
				.filter(course -> !course.getContentid().equals("2717306") && !course.getContentid().equals("2804721"))// 적절하지않은 데이터 필터링
				.collect(Collectors.toList());

		// 필터링된 목록을 섞은 후 처음 5개 항목 추출
		// Service쪽으로 ajax코드 옮겨야할지도?
		Collections.shuffle(filteredList);
		List<Course> selectedCourses = filteredList.subList(0, Math.min(5, filteredList.size()));

		List<String> contentIds = new ArrayList<>(); // 추출된 5개 여행코스의 ID
		for (Course course : selectedCourses) {
			contentIds.add(course.getContentid());
		}
		Map<String, List<?>> titleInfo;
		try {
			titleInfo = service.getTitleList(contentIds); // 서비스에서 api호출
			List<?> titleList = titleInfo.get("titleList");
			List<?> titleLength = titleInfo.get("titleLength");

			System.out.println("aaaaaaaa" + titleList);
			System.out.println("bbbbbbbb" + titleLength);

			model.addAttribute("titleList", titleList); // 코스에 포함된 여행지의 제목만 추출
			model.addAttribute("titleLength", titleLength); // 코스에 포함된 여행지 갯수
			model.addAttribute("courseList", selectedCourses); // 추출된 코스 5개 코스 리스트로 전달
			log.info("!!"+model.getAttribute("courseList"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "home/slider_2";
	}
	
	@GetMapping("/course_write")
	public String course_write() {
		return "course/course_write";
	}
}
