package com.raon.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.lang.model.element.ModuleElement;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.raon.domain.Course;
import com.raon.domain.TourDetailInfo;
import com.raon.domain.TourInfo;
import com.raon.domain.allTourInfo;
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
			log.info(request+"!!!!"+response+"!!!!!!!"+model);
			log.info("controller -> detail success");
			//service.getTourImage(request, response, model);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			log.info("controller -> detail fail");
		}
		
		return "tour/tour_detail";
	}
	@GetMapping("/search")
	public String search(HttpServletRequest request, HttpServletResponse response, Model model,  @RequestParam(defaultValue = "1") int page) {
		try {
			service.searchTourList(request, response, model, page);
			log.info("controller -> search success");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			log.info("controller -> search fail");
		}
		
		return "tour/tour_search";
	}
	
//	slider_1용
	@GetMapping("/slider1")
	public String slider1(Model model) {
	    try {
	        List<allTourInfo> allTourInfos = new ArrayList<>();
	        service.getTourList2(model);
	        List<TourInfo> tourInfoList = (List<TourInfo>) model.getAttribute("tList2");
	        Collections.shuffle(tourInfoList);
	        List<TourInfo> selectedTour = tourInfoList.subList(0, Math.min(6, tourInfoList.size()));
	        String[] contentids = new String[selectedTour.size()];
	        int index = 0;
	        List<String> selectedOverView = new ArrayList<>(); // overview를 저장할 리스트

	        for (TourInfo temp : selectedTour) {
	            contentids[index] = temp.getContentid(); // contentid 값을 배열에 저장
	            index++;

	            // allTourInfo 객체 생성 및 정보 저장
	            allTourInfo allTourInfo = new allTourInfo();
	            allTourInfo.setContentid(temp.getContentid());
	            allTourInfo.setTitle(temp.getTitle());
	            allTourInfo.setMapx(temp.getMapx());
	            allTourInfo.setMapy(temp.getMapy());
	            allTourInfo.setFirstimage(temp.getFirstimage());
	            allTourInfos.add(allTourInfo);
	        }

	        // contentids를 사용하여 overview 정보 가져오기
	        service.getTourDetail2(contentids, model);
	        List<TourDetailInfo> tourDetailInfoList = (List<TourDetailInfo>) model.getAttribute("overviewList");
	        for (TourDetailInfo detailInfo : tourDetailInfoList) {
	            selectedOverView.add(detailInfo.getOverview());
	        }

	        // allTourInfos와 selectedTour를 합치는 작업
	        for (int i = 0; i < allTourInfos.size(); i++) {
	            allTourInfos.get(i).setOverview(selectedOverView.get(i));
	        }
	        model.addAttribute("allTourInfos", allTourInfos); // 모든 관광 정보
	    } catch (IOException e) {
	        e.printStackTrace();
	    }

	    return "home/slider_1";
	}

	

}
