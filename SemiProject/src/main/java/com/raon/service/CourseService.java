package com.raon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.raon.domain.Course;
import com.raon.mapper.CourseMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class CourseService {
    @Autowired
    private CourseMapper mapper;
    
    public List<Course> getList(){
        log.info("Service->getList()");
        return mapper.getList();
    }
}