package com.raon.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class BusArrive {
	private int arrprevstationcnt; //남은 정류장
    private int arrtime; // 남은 시간 (초)
    private String nodeid; //정류장id
    private String nodenm;//정류장 이름
    private String routeid; //노선 id
    private int routeno; //노선번호
    private String routetp; //노선유형 (마을버스..)
    private String vehicletp;//차량유형 (저상버스..)
}
