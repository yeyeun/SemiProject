package com.raon.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ContentDetail {
	private String title;
	private String contentid;
	private String firstimage;
	private String mapx;
	private String mapy;
	private String mlevel;
	private String overview;
	private String addr1;
}
