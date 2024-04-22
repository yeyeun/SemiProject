package com.raon.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.raon.domain.Course;
import com.raon.domain.Criteria;
import com.raon.domain.PageDTO;
import com.raon.service.CourseService;
import com.raon.service.MypageService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
@RequestMapping("/course/*")
public class CourseController {
	private CourseService service;
	private MypageService mypageservice;

	@GetMapping("/allList")
	public void allList(Model model, Criteria cri) {
		List<Course> allList = service.getListPaging(cri);
		model.addAttribute("allList", allList);
		int total = service.getTotal(cri);
		PageDTO dto = new PageDTO(cri, total);
		model.addAttribute("pagingDTO", dto);

	}

	@GetMapping("/detail")
	public void detail(@RequestParam("contentid") String contentid, Model model) {
		log.info("----course " + contentid + "번 상세조회----");
		try {
			List<String> list = service.getSubContents(contentid); // 해당 코스의 subcontentid값 배열로 받아오기
			service.getDetailInfo(list, model);
			model.addAttribute("course", service.detail(contentid)); // 코스 기본정보 model로 저장
		} catch (IOException e) {
			log.info("----course 상세조회 실패----");
		}
	}

	@GetMapping("/list")
	public String list(Model model) { // 코드 전체 정보 중 5개만 추출해서 List형식으로 리턴
		log.info("course_list");
		List<Course> courseList = service.getList();
		// contentid가 2717306인 항목을 제외하고 필터링
		List<Course> filteredList = courseList.stream()
				.filter(course -> !course.getContentid().equals("2717306") && !course.getContentid().equals("2804721"))// 적절하지않은
																														// 데이터
																														// 필터링
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
			log.info("!!" + model.getAttribute("courseList"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "home/slider_2";
	}

	@GetMapping("/write")
	public String course_write(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		if (request.getSession().getAttribute("loginId") == null) { // 로그인 여부 확인
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인 후 이용해주세요')");
			out.println("history.back()");
			out.println("</script>");
			out.flush();
			throw new Exception();
		}
		String loginId = (String) request.getSession().getAttribute("loginId");
		model.addAttribute("mytourList", mypageservice.read(loginId));
		log.info("@@@" + model.getAttribute("mytourList"));
//		mypageservice.getTourDetail(request, response, model);
		return "course/write";
	}

	@GetMapping("/add")
	public String addCourse(@RequestParam("contentid") String contentId, @RequestParam("firstimage") String firstimage,
			@RequestParam("subcontentid") String subcontentid, @RequestParam("id") String id,
			@RequestParam("title") String title, @RequestParam("overview") String overview, Model model,
			RedirectAttributes rttr) {
		String modifiedSubcontentid = "[\"" + subcontentid.replace(",", "\",\"") + "\"]";
		firstimage = firstimage.equals("undefined") ? null : firstimage;
		modifiedSubcontentid = modifiedSubcontentid.equals("[\"\"]") ? null : modifiedSubcontentid;
		service.add(contentId, firstimage, modifiedSubcontentid, id, title, overview);
		rttr.addFlashAttribute("result", "write");
//		log.info("!!!!!!"+contentId+firstimage+subcontentid+title+overview+id);
		return "redirect:/course/allList";
	}

	@GetMapping("/remove")
	public String remove(@RequestParam("contentid") String contentid, RedirectAttributes rttr) {
		log.info(contentid + " 여행코스 삭제=========");
		if (service.remove(contentid) && service.removeCommentCo(contentid)) {
			rttr.addFlashAttribute("result", "remove");
		}
		return "redirect:/course/allList";

	}

	
//	var course = {
//			contentid : contentid,
//			title : modalInputTitle.val(),
//			subcontentid: selectedIds,
//			overview : modalInputOverview.val()
//		};
	
	
	@GetMapping("/modify")
	public String modifyCourse(@RequestParam("contentid") String contentid, @RequestParam("firstimage") String firstimage,
			@RequestParam("subcontentid") String subcontentid,@RequestParam("title") String title, @RequestParam("overview") String overview, Model model,
			RedirectAttributes rttr) {
		String modifiedSubcontentid = "[\"" + subcontentid.replace(",", "\",\"") + "\"]";
		firstimage = firstimage.equals("undefined") ? null : firstimage;
		modifiedSubcontentid = modifiedSubcontentid.equals("[\"\"]") ? null : modifiedSubcontentid;
		service.modify(contentid, firstimage, modifiedSubcontentid,title, overview);
		rttr.addFlashAttribute("result", "modify");
		return "redirect:/course/allList";
	}

	 
}
