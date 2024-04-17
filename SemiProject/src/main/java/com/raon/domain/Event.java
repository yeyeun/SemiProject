package com.raon.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Event {
	//searchFestival1
	private String addr1;
	private String contentid;
	private String eventstartdate;
	private String eventenddate;
	private String firstimage;
	private String mapx;
	private String mapy;
	private String mlevel;
	private String title;
	//detailImage1
	private String imgname; //포스터 이미지 추출용 이미지이름
	private String originimgurl; //캐러셀용 이미지
	//detailInfo
	private String infotext; //행사 내용
	//detailCommon
	private String homepage; //홈페이지링크
	private String telname; //주최지 이름
	private String tel;//문의 전화
	//detailIntro
	private String eventplace;
	private String playtime;
	private String usetimefestival;
	private String sponsor1;
	private String sponsor2;
	
	public Event(String addr1, String contentid, String eventstartdate, String eventenddate, String firstimage,
			String mapx, String mapy, String mlevel, String tel, String title) {
		super();
		this.addr1 = addr1;
		this.contentid = contentid;
		this.eventstartdate = eventstartdate;
		this.eventenddate = eventenddate;
		this.firstimage = firstimage;
		this.mapx = mapx;
		this.mapy = mapy;
		this.mlevel = mlevel;
		this.tel = tel;
		this.title = title;
	}

	public Event(String imgname, String originimgurl) {
		super();
		this.imgname = imgname;
		this.originimgurl = originimgurl;
	}	

	public Event(String eventplace, String playtime, String usetimefestival, String sponsor1, String sponsor2) {
		super();
		this.eventplace = eventplace;
		this.playtime = playtime;
		this.usetimefestival = usetimefestival;
		this.sponsor1 = sponsor1;
		this.sponsor2 = sponsor2;
	}

	public Event(String playtime, String usetimefestival, String sponsor1, String sponsor2) {
		super();
		this.playtime = playtime;
		this.usetimefestival = usetimefestival;
		this.sponsor1 = sponsor1;
		this.sponsor2 = sponsor2;
	}

	public Event(String mapx, String mapy, String mlevel, String homepage, String telname, String tel) {
		super();
		this.mapx = mapx;
		this.mapy = mapy;
		this.mlevel = mlevel;
		this.homepage = homepage;
		this.telname = telname;
		this.tel = tel;
	}

	

	
}
