package com.raon.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.raon.domain.Board;
import com.raon.domain.Criteria;
import com.raon.mapper.BoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class BoardService {
	@Setter(onMethod_=@Autowired)
	private BoardMapper mapper;
	
	public List<Board> getList(){
		log.info("getList..........");
		return mapper.getList();
	}
	
	public List<Board> getListPaging(Criteria cri){
		return mapper.getListPaging(cri);
	}
	
	public int getTotal() {
		log.info("getTotal......");
		return mapper.getTotal();
	}
		
	public void write(Board board) {
		log.info("write....." + board.getBno());
		mapper.insertSelectKey(board);
	}
	
	public Board read(Integer bno) {
		log.info("get....."+bno);
		return mapper.read(bno);
	}
	
	public boolean modify(Board board) {
		log.info("modify....."+board);
		return mapper.update(board)==1;
	}
	
	public boolean remove(Integer bno) {
		log.info("remove....."+bno);
		return mapper.delete(bno)==1;
	}
}
