package com.raon.domain;

import java.util.Date;

import lombok.Data;

@Data
public class Board {
	private Integer bno;
	private String btype;
	private String title;
	private String content;
	private String writer;
	private Date regDate;
	private Integer hit;
}
