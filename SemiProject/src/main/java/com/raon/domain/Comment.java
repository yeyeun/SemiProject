package com.raon.domain;

import java.util.Date;

import lombok.Data;

@Data
public class Comment {
	private Integer commentid;
	private Integer bno;
	private String content;
	private String id;
	private Date regDate;
}
