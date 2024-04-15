package com.raon.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.raon.service.CourseService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
public class CourseController {
    private CourseService service;
    
    @GetMapping("/course/list")
    public String list(Model model) {
        log.info("course_list");
        model.addAttribute("courseList", service.getList());
        return "home/slider_2";
    }
}
