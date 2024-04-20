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

import com.raon.domain.Comment;
import com.raon.service.CommentService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/comments")
@RestController
@Log4j
@AllArgsConstructor
public class CommentController {
	private CommentService service;
	
	@PostMapping(value="/new", consumes="application/json",produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody Comment comment){
		log.info("Comment : " + comment);
		int insertCount = service.insert(comment);
		log.info("Comment INSERT COUNT : " + insertCount);
		return insertCount == 1 ? new ResponseEntity<>("success",HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value="/pages/{bno}/{page}", produces= {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<List<Comment>> getList(@PathVariable("page") int page, @PathVariable("bno") Integer bno){
		log.info("getList..........");
		return new ResponseEntity<> (service.getListByBno(bno), HttpStatus.OK);
	}
	
	//댓글 조회
	@GetMapping(value="/{commentid}", produces= {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<Comment> get(@PathVariable("commentid") Integer commentid){
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
	public ResponseEntity<String> modify(@RequestBody Comment comment, @PathVariable("commentid") Integer commentid){
		comment.setCommentid(commentid);
		log.info("commentid : " + commentid);
		log.info("modify : " + comment);
		return service.update(comment)==1? new ResponseEntity<>("success", HttpStatus.OK)
				:new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
