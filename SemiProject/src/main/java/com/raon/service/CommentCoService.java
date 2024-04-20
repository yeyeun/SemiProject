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
	
	public int insert(CommentCo commentco) {
		log.info("register...."+commentco);
		return mapper.insert(commentco);
	}
	
	public CommentCo read(Integer commentid) {
		log.info("get...."+commentid);
		return mapper.read(commentid);
	}
	
	public int update(CommentCo commentco) {
		log.info("modify...."+commentco);
		return mapper.update(commentco);
	}
	
	public int delete(Integer commentid) {
		log.info("remove...."+commentid);
		return mapper.delete(commentid);
	}
	
	public List<CommentCo> getListByContentid(String contentid){
		log.info("get Comment of a Course......" + contentid);
		return mapper.getListByContentid(contentid);
	}
}
