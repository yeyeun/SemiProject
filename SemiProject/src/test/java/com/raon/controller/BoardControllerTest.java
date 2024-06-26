package com.raon.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
public class BoardControllerTest {
	@Setter(onMethod_= {@Autowired})
	private WebApplicationContext ctx;
	private MockMvc mockMvc; // MockMvc : 가짜 mvc
	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	@Test
	public void testList() throws Exception {
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/board/list"))
				.andReturn().getModelAndView().getModelMap());
	}
	
	@Test
	public void testRegister() throws Exception {
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/write")
				.param("title", "test from controller")
				.param("content", "test from controller")
				.param("writer", "user0000"))
				.andReturn().getModelAndView().getViewName();
		log.info(resultPage);
	}
	
	@Test
	public void testRead() throws Exception {
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/board/read")
				.param("bno", "2")).andReturn().getModelAndView().getModelMap());
	}
	
	@Test
	public void testModify() throws Exception {
		String resultPage =
				mockMvc.perform(MockMvcRequestBuilders.post("/board/modify")
						.param("bno", "111")
						.param("title", "111번 제목")
						.param("content", "111번 내용내용"))
				.andReturn().getModelAndView().getViewName();
		log.info(resultPage);
	}
	
	@Test
	public void testRemove() throws Exception {
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/remove")
				.param("bno", "112")).andReturn().getModelAndView().getViewName();
		log.info(resultPage);
	}
}
