package com.raon.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class finalbus {
	private String endnodenm; //마지막 정류소
    private String routeid; //버스id
    private String routeno; //버스 번호
    private String routetp; //버스 종류(급행, 간선, 순환,..)
    private String startnodenm; //출발 정류소
	private int arrprevstationcnt; //남은 정류장
    private int arrtime; // 남은 시간 (초)
}
