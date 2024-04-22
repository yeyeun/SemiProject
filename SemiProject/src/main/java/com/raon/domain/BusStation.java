package com.raon.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class BusStation {
    private int citycode;
    private Double gpslati; //위도 
    private Double gpslong; //경도
    private String nodeid; //정류소아이디
    private String nodenm; //정류소이름

}
