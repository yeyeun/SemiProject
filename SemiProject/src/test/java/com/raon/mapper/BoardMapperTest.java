package com.raon.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.raon.domain.Board;
import com.raon.domain.Criteria;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTest {
	@Setter(onMethod_= {@Autowired})
	private BoardMapper mapper;
	
	@Test
	public void testGetList() {
		mapper.getList().forEach(board->log.info(board)); //람다식
	}
	
	@Test
	public void testInsert() {
		Board board = new Board();
		board.setTitle("새로 작성하는 글");
		board.setContent("새로 작성하는 내용");
		board.setWriter("newbie");
		mapper.insert(board);
		log.info(board);
	}
	
	@Test
	public void testInsertSelectKey() {
		Board board = new Board();
		board.setTitle("새로 작성하는 글");
		board.setContent("새로 작성하는 내용");
		board.setWriter("newbie");
		mapper.insertSelectKey(board);
		log.info(board);
	}
	
	@Test
	public void testRead() {
		Board board = mapper.read(1);
		log.info(board);
	}
	
	@Test
	public void testDelete() {
		log.info("DELETE COUNT : " + mapper.delete(115));
	}
	
	@Test
	public void testUpdate() {
		Board board = new Board();
		board.setBno(8);
		board.setTitle("수정한 제목");
		board.setContent("수정한 내용입니다");
		int count = mapper.update(board);
		log.info("UPDATE COUNT : " + count);
	}
	
	/* 페이징 적용 테스트 */
	@Test
	public void testGetListPaging() {
		Criteria cri = new Criteria(1,10);
		List list = mapper.getListPaging(cri);
		list.forEach(board -> log.info(""+board));
	}
	
}
