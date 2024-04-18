package com.raon.service;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.raon.mapper.CourseMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class CourseServiceTest {
	@Setter(onMethod_= {@Autowired})
	private CourseService service;
	
	@Setter(onMethod_= {@Autowired})
	private CourseMapper mapper;
	
	@Test
    public List<String> testGetSubContents(String contentid) {
    	String sub = mapper.getSubContents("1855198");
    	log.info("contentid : " + contentid);
    	log.info("subcontentid : " + sub);
    	return null;
    }
}
