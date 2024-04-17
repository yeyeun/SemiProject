package com.raon.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class TourInfo {
	private String title;
	private String addr1;
	private String addr2;
	private String contentid;
	private String mapx;
	private String mapy;
	private String firstimage;
}
