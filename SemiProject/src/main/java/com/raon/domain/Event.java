package com.raon.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Event {
	private String addr1;
	private String contentid;
	private String eventstartdate;
	private String eventenddate;
	private String firstimage;
	private double mapx;
	private double mapy;
	private int mlevel;
	private String tel;
	private String title;
}
