package com.raon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.raon.domain.CommentCo;
import com.raon.mapper.CommentCoMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class CommentCoService {
	@Setter(onMethod_=@Autowired)
	private CommentCoMapper mapper;
	
	public int insert(CommentCo comment) {
		log.info("register...."+comment);
		return mapper.insert(comment);
	}
	
	public CommentCo read(Integer commentid) {
		log.info("get...."+commentid);
		return mapper.read(commentid);
	}
	
	public int update(CommentCo comment) {
		log.info("modify...."+comment);
		return mapper.update(comment);
	}
	
	public int delete(Integer commentid) {
		log.info("remove...."+commentid);
		return mapper.delete(commentid);
	}
	
	public List<CommentCo> getListByBno(Integer bno){
		log.info("get Reply Comment of a Board......" + bno);
		return mapper.getListByBno(bno);
	}
}
