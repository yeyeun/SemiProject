package com.raon.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class TourDetailInfo {
	private String title;
	private String homepage;
	private String overview;
	private String mapx;
	private String mapy;
	private String tel;
	private String mlevel;
}
