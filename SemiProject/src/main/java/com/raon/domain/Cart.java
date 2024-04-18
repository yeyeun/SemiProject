package com.raon.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Cart {
	private String cartid;
	private String id;
	private String contentid;
	private String title;
	private String firstimage;
}
