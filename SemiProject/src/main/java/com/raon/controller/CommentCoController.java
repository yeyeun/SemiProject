package com.raon.controller;

import java.util.*;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.raon.domain.CommentCo;
import com.raon.service.CommentCoService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/commentsCo")
@RestController
@Log4j
@AllArgsConstructor
public class CommentCoController {
	private CommentCoService service;
	
	@PostMapping(value="/new", consumes="application/json",produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody CommentCo commentco){
		log.info("CommentCo : " + commentco);
		int insertCount = service.insert(commentco);
		log.info("CommentCo INSERT COUNT : " + insertCount);
		return insertCount == 1 ? new ResponseEntity<>("success",HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value="/pages/{contentid}/{page}", produces= {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<List<CommentCo>> getList(@PathVariable("page") int page, @PathVariable("contentid") String contentid){
		log.info("getList..........");
		return new ResponseEntity<> (service.getListByContentid(contentid), HttpStatus.OK);
	}
	
	//댓글 조회
	@GetMapping(value="/{commentid}", produces= {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<CommentCo> get(@PathVariable("commentid") Integer commentid){
		log.info("get : " + commentid);
		return new ResponseEntity<> (service.read(commentid), HttpStatus.OK);
	}
	
	//댓글 삭제
	@DeleteMapping(value="/{commentid}", produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("commentid") Integer commentid){
		log.info("remove : " + commentid);
		return service.delete(commentid)==1? new ResponseEntity<>("success", HttpStatus.OK)
				:new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//댓글 수정
	@RequestMapping(method={RequestMethod.PUT, RequestMethod.PATCH},
			value="/{commentid}", consumes="application/json", produces={MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@RequestBody CommentCo commentco, @PathVariable("commentid") Integer commentid){
		commentco.setCommentid(commentid);
		log.info("commentid : " + commentid);
		log.info("modify : " + commentco);
		return service.update(commentco)==1? new ResponseEntity<>("success", HttpStatus.OK)
				:new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
