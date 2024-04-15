package com.raon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.raon.domain.Comment;
import com.raon.mapper.BoardMapper;
import com.raon.mapper.CommentMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class CommentService {
	@Setter(onMethod_=@Autowired)
	private CommentMapper mapper;
	
	public int insert(Comment comment) {
		log.info("register...."+comment);
		return mapper.insert(comment);
	}
	
	public Comment read(Integer commentid) {
		log.info("get...."+commentid);
		return mapper.read(commentid);
	}
	
	public int update(Comment comment) {
		log.info("modify...."+comment);
		return mapper.update(comment);
	}
	
	public int delete(Integer commentid) {
		log.info("remove...."+commentid);
		return mapper.delete(commentid);
	}
	
	public List<Comment> getListByBno(Integer bno){
		log.info("get Reply Comment of a Board......" + bno);
		return mapper.getListByBno(bno);
	}
}
