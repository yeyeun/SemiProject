package com.raon.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.lang.model.element.ModuleElement;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.raon.domain.Bus;
import com.raon.domain.BusArrive;
import com.raon.domain.BusStation;
import com.raon.domain.Course;
import com.raon.domain.TourDetailInfo;
import com.raon.domain.TourInfo;
import com.raon.domain.allTourInfo;
import com.raon.domain.finalbus;
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
			service.getBusStation(request, response, model);
			service.getTourImage(request, response, model);
			List<BusStation> allbus = (List<BusStation>) model.getAttribute("BusStationList");
			for(BusStation bus:allbus) {
				log.info("!!!!!!"+bus.getNodeid());
			}
			if(allbus.get(0).getCitycode() != -1) {
//				service.getBusArrive(model);
				log.info("정류장이 있을경우 도착정보 호출");
			}else {
				log.info("정류장이 없을경우");
			}
			
//			log.info("!!!!!"+model.getAttribute("BusStationList"));
//			log.info("@@@@@"+model.getAttribute("BusArriveList"));
			
			

			log.info("controller -> detail success");
			//service.getTourImage(request, response, model);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			log.info("controller -> detail fail");
		}
		
		return "tour/tour_detail";
	}
	
	@GetMapping("/buslist")
	@ResponseBody
	public List<Bus> buslist(@RequestParam("nodeid") String nodeid,Model model) {
		try {
			service.getAllBus(nodeid, model);
			List<Bus> businfo =(List<Bus>) model.getAttribute("allbus");
			log.info("@모든버스정보@"+businfo);
			return businfo;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
	}
	
	@GetMapping("/arrivelist")
	@ResponseBody
	public List<finalbus> busarrive(@RequestParam("nodeid") String nodeid,@RequestParam("nodenm") String nodenm,  Model model) {
		int index=0;
		try {
			//도착하는 버스
			service.getBusArrive(nodeid, model);
			List<BusArrive> busarriveinfo =(List<BusArrive>) model.getAttribute("BusArriveList");
			
			//모든 버스
			service.getAllBus(nodeid, model);
			List<finalbus> businfo =(List<finalbus>) model.getAttribute("allbus");	
			log.info("@모든버스정보@"+businfo);
			
			
			// businfo의 갯수만큼 반복
			for (finalbus bus : businfo) {
			    boolean found = false; // 해당 버스에 대한 정보가 있는지 여부를 확인하기 위한 플래그

			    // busarriveinfo를 순회하면서 해당 routeid를 가진 정보가 있는지 확인
			    for (BusArrive arrive : busarriveinfo) {
			        if (arrive.getRouteid().equals(bus.getRouteid())) { // routeid가 일치하는 경우
			        	bus.setArrprevstationcnt(arrive.getArrprevstationcnt());
			        	bus.setArrtime(arrive.getArrtime());
			            found = true; // 정보가 있는 것으로 플래그를 설정
			            break; // 더 이상 확인할 필요가 없으므로 반복문 종료
			        }
			    }

			    // 해당 버스에 대한 정보가 없는 경우
			    if (!found) {
			        // busarriveinfo에 "정보없음" 항목 추가
			        BusArrive notAvailable = new BusArrive();
			        notAvailable.setArrprevstationcnt(-1);
			        notAvailable.setArrtime(-1);
			        notAvailable.setNodeid(nodeid);
			        notAvailable.setNodenm(nodenm);
			        notAvailable.setRouteid(bus.getRouteid());
			        notAvailable.setRouteno(bus.getRouteno());
			        notAvailable.setRoutetp(bus.getRoutetp());
			        notAvailable.setVehicletp("정보없음");

			        // 항상 리스트의 마지막에 추가하는 대신, 첫 번째 위치에 추가합니다.
			        busarriveinfo.add(index, notAvailable); // 첫 번째 위치에 "정보없음" 항목 추가
			        
			    }
			    index++;
			}
			log.info("@버스도착정보@"+businfo);
			return businfo;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
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