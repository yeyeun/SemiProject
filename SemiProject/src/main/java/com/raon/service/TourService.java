package com.raon.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.raon.mapper.TourMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class TourService {
	@Setter(onMethod_=@Autowired)
	private TourMapper mapper;
	

}
