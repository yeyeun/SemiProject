package com.raon.domain;

import java.util.Date;

import lombok.Data;

@Data
public class CommentCo {
	private Integer commentid;
	private String contentid;
	private String content;
	private String id;
	private Date regDate;
}
