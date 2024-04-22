package com.raon.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.annotations.Param;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.raon.domain.Bus;
import com.raon.domain.BusArrive;
import com.raon.domain.BusStation;
import com.raon.domain.TourDetailInfo;
import com.raon.domain.TourInfo;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class TourService {
	public void searchTourList(HttpServletRequest request, HttpServletResponse response, Model model, int page) throws IOException{
		try {
			String keyword = request.getParameter("keyword");
			StringBuilder urlBuilder = new StringBuilder(
					"https://apis.data.go.kr/B551011/KorService1/searchKeyword1"); /* URL */
			urlBuilder.append("?" + URLEncoder.encode("numOfRows", "UTF-8") + "="
					+ URLEncoder.encode("12", "UTF-8")); /* 한 페이지 결과 수 */
			urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode(Integer.toString(page), "UTF-8"));
			urlBuilder.append(
					"&" + URLEncoder.encode("MobileOS", "UTF-8") + "=" + URLEncoder.encode("ETC", "UTF-8")); /* 조회시작일자 */
			urlBuilder.append(
					"&" + URLEncoder.encode("MobileApp", "UTF-8") + "=" + URLEncoder.encode("raon", "UTF-8")); /* 조회종료일자 */
			urlBuilder.append(
					"&" + URLEncoder.encode("_type", "UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /* xml 또는 json */
			urlBuilder.append(
					"&" + URLEncoder.encode("listYN", "UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8")); /* 조회시작일자 */
			urlBuilder
					.append("&" + URLEncoder.encode("arrange", "UTF-8") + "=" + URLEncoder.encode("A", "UTF-8")); /* 측정소명 */
			urlBuilder.append("&" + URLEncoder.encode("keyword", "UTF-8") + "=" + URLEncoder.encode(keyword, "UTF-8")); /* 측정소명 */
			urlBuilder.append(
					"&" + URLEncoder.encode("contentTypeId", "UTF-8") + "=" + URLEncoder.encode("12", "UTF-8")); /* 측정소명 */
			urlBuilder.append(
					"&" + URLEncoder.encode("areaCode", "UTF-8") + "=" + URLEncoder.encode("39", "UTF-8")); /* 측정소명 */
			urlBuilder.append("&" + URLEncoder.encode("serviceKey", "UTF-8")
					+ "=b7k%2B9H2DZnNoOhZSPNTopjx1cG%2F8y74JvA2aFmp4dlvoRTGzmxGL976Dcdg0PTLdbegGkqm466WbLV5PHNOwmw%3D%3D");

			URL url = new URL(urlBuilder.toString());
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-type", "application/json");
			System.out.println("Response code: " + conn.getResponseCode());
			BufferedReader rd;
			if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			} else {
				rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}
			StringBuilder sb = new StringBuilder();
			String line;
			while ((line = rd.readLine()) != null) {
				sb.append(line);
			}
			rd.close();
			conn.disconnect();
			System.out.println(sb.toString());
			JSONObject jsonObject = new JSONObject(sb.toString());
			List<TourInfo> searchList = new ArrayList<TourInfo>();
			jsonObject = jsonObject.getJSONObject("response").getJSONObject("body").getJSONObject("items");
			JSONArray jsonArray = jsonObject.getJSONArray("item");
			JSONObject jsonCount = new JSONObject(sb.toString());
			int totalCnt = jsonCount.getJSONObject("response").getJSONObject("body").getInt("totalCount");
			int totalPages = (totalCnt + 11) / 12;
			for (int i = 0; i < jsonArray.length(); i++) {
				searchList.add(new TourInfo(jsonArray.getJSONObject(i).getString("title"),
						jsonArray.getJSONObject(i).getString("addr1"), jsonArray.getJSONObject(i).getString("addr2"),
						jsonArray.getJSONObject(i).getString("contentid"), jsonArray.getJSONObject(i).getString("mapx"),
						jsonArray.getJSONObject(i).getString("mapy"), jsonArray.getJSONObject(i).getString("firstimage")

				));

			}
			model.addAttribute("searchList", searchList);
			model.addAttribute("totalPages", totalPages);
		}catch(Exception e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath()+ "/tour/list");
		}
		
	}
	public void getTourList(Model model, int page) throws IOException {
		// TODO Auto-generated method stub
		// 클라이언트에서 넘어온 페이지 번호와 페이지 크기를 받아옵니다.
		StringBuilder urlBuilder = new StringBuilder(
				"https://apis.data.go.kr/B551011/KorService1/areaBasedList1"); /* URL */
		urlBuilder.append("?" + URLEncoder.encode("numOfRows", "UTF-8") + "="
				+ URLEncoder.encode("12", "UTF-8")); /* 한 페이지 결과 수 */
		urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode(Integer.toString(page), "UTF-8"));
		urlBuilder.append(
				"&" + URLEncoder.encode("MobileOS", "UTF-8") + "=" + URLEncoder.encode("ETC", "UTF-8")); /* 조회시작일자 */
		urlBuilder.append(
				"&" + URLEncoder.encode("MobileApp", "UTF-8") + "=" + URLEncoder.encode("raon", "UTF-8")); /* 조회종료일자 */
		urlBuilder.append(
				"&" + URLEncoder.encode("_type", "UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /* xml 또는 json */
		urlBuilder.append(
				"&" + URLEncoder.encode("listYN", "UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8")); /* 조회시작일자 */
		urlBuilder
				.append("&" + URLEncoder.encode("arrange", "UTF-8") + "=" + URLEncoder.encode("A", "UTF-8")); /* 측정소명 */
		urlBuilder.append(
				"&" + URLEncoder.encode("contentTypeId", "UTF-8") + "=" + URLEncoder.encode("12", "UTF-8")); /* 측정소명 */
		urlBuilder.append(
				"&" + URLEncoder.encode("areaCode", "UTF-8") + "=" + URLEncoder.encode("39", "UTF-8")); /* 측정소명 */
		urlBuilder.append("&" + URLEncoder.encode("serviceKey", "UTF-8")
				+ "=b7k%2B9H2DZnNoOhZSPNTopjx1cG%2F8y74JvA2aFmp4dlvoRTGzmxGL976Dcdg0PTLdbegGkqm466WbLV5PHNOwmw%3D%3D");

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/json");
		System.out.println("Response code: " + conn.getResponseCode());
		BufferedReader rd;
		if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}
		rd.close();
		conn.disconnect();
		System.out.println(sb.toString());
		JSONObject jsonObject = new JSONObject(sb.toString());
		List<TourInfo> tList = new ArrayList<TourInfo>();
		jsonObject = jsonObject.getJSONObject("response").getJSONObject("body").getJSONObject("items");
		JSONArray jsonArray = jsonObject.getJSONArray("item");
		JSONObject jsonCount = new JSONObject(sb.toString());
		int totalCnt = jsonCount.getJSONObject("response").getJSONObject("body").getInt("totalCount");
		int totalPages = (totalCnt + 11) / 12;
		for (int i = 0; i < jsonArray.length(); i++) {
			tList.add(new TourInfo(jsonArray.getJSONObject(i).getString("title"),
					jsonArray.getJSONObject(i).getString("addr1"), jsonArray.getJSONObject(i).getString("addr2"),
					jsonArray.getJSONObject(i).getString("contentid"), jsonArray.getJSONObject(i).getString("mapx"),
					jsonArray.getJSONObject(i).getString("mapy"), jsonArray.getJSONObject(i).getString("firstimage")

			));

		}
		model.addAttribute("tList", tList);
		model.addAttribute("totalPages", totalPages);
	
			
	}

//	public void getTourImage(HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {
//	    List<String> imgUrls = new ArrayList<String>();
//	    String contentId = request.getParameter("contentid");
//	    StringBuilder urlBuilder = new StringBuilder("https://apis.data.go.kr/B551011/KorService1/detailImage1");
//	    urlBuilder.append("?" + URLEncoder.encode("MobileOS", "UTF-8") + "=" + URLEncoder.encode("ETC", "UTF-8"));
//	    urlBuilder.append("&" + URLEncoder.encode("MobileApp", "UTF-8") + "=" + URLEncoder.encode("raon", "UTF-8"));
//	    urlBuilder.append("&" + URLEncoder.encode("_type", "UTF-8") + "=" + URLEncoder.encode("json", "UTF-8"));
//	    urlBuilder.append("&" + URLEncoder.encode("contentId", "UTF-8") + "=" + URLEncoder.encode(contentId, "UTF-8"));
//	    urlBuilder.append("&" + URLEncoder.encode("imageYN", "UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8"));
//	    urlBuilder.append("&" + URLEncoder.encode("subImageYN", "UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8"));
//	    urlBuilder.append("&" + URLEncoder.encode("serviceKey", "UTF-8") + "=b7k%2B9H2DZnNoOhZSPNTopjx1cG%2F8y74JvA2aFmp4dlvoRTGzmxGL976Dcdg0PTLdbegGkqm466WbLV5PHNOwmw%3D%3D");
//
//	    URL url = new URL(urlBuilder.toString());
//	    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
//	    conn.setRequestMethod("GET");
//	    conn.setRequestProperty("Content-type", "application/json");
//	    System.out.println("Response code: " + conn.getResponseCode());
//	    BufferedReader rd;
//	    if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
//	        rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
//	    } else {
//	        rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
//	    }
//	    StringBuilder sb = new StringBuilder();
//	    String line;
//	    while ((line = rd.readLine()) != null) {
//	        sb.append(line);
//	    }
//	    rd.close();
//	    conn.disconnect();
//	    System.out.println(sb.toString());
//	    JSONObject jsonObject = new JSONObject(sb.toString());
//	    jsonObject = jsonObject.getJSONObject("response").getJSONObject("body").getJSONObject("items");
//	    JSONArray jsonArray = jsonObject.getJSONArray("item");
//	    System.out.println(jsonObject.keys());
//	    for (int i = 0; i < jsonArray.length(); i++) {
//	        imgUrls.add(jsonArray.getJSONObject(i).getString("originimgurl"));
//	    }
//	    // 이미지 URL을 클라이언트로 전송
//	    model.addAttribute("imgUrls", imgUrls);
//	}
	public void getTourDetail(HttpServletRequest request, HttpServletResponse response, Model model)
			throws IOException {
		// TODO Auto-generated method stub
		String contentId = request.getParameter("contentid");
		StringBuilder urlBuilder = new StringBuilder(
				"https://apis.data.go.kr/B551011/KorService1/detailCommon1"); /* URL */
		urlBuilder.append(
				"?" + URLEncoder.encode("MobileOS", "UTF-8") + "=" + URLEncoder.encode("ETC", "UTF-8")); /* 조회시작일자 */
		urlBuilder.append(
				"&" + URLEncoder.encode("MobileApp", "UTF-8") + "=" + URLEncoder.encode("raon", "UTF-8")); /* 조회종료일자 */
		urlBuilder.append(
				"&" + URLEncoder.encode("_type", "UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /* xml 또는 json */
		urlBuilder.append("&" + URLEncoder.encode("contentId", "UTF-8") + "="
				+ URLEncoder.encode(contentId, "UTF-8")); /* 한 페이지 결과 수 */ /* Service Key */
		urlBuilder.append(
				"&" + URLEncoder.encode("defaultYN", "UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8")); /* 조회시작일자 */
		urlBuilder.append(
				"&" + URLEncoder.encode("firstImageYN", "UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8")); /* 조회시작일자 */
		urlBuilder.append(
				"&" + URLEncoder.encode("areacodeYN", "UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8")); /* 조회시작일자 */
		urlBuilder.append(
				"&" + URLEncoder.encode("mapinfoYN", "UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8")); /* 조회시작일자 */
		urlBuilder.append(
				"&" + URLEncoder.encode("overviewYN", "UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8")); /* 조회시작일자 */
		urlBuilder.append("&" + URLEncoder.encode("serviceKey", "UTF-8")
				+ "=b7k%2B9H2DZnNoOhZSPNTopjx1cG%2F8y74JvA2aFmp4dlvoRTGzmxGL976Dcdg0PTLdbegGkqm466WbLV5PHNOwmw%3D%3D");

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/json");
		System.out.println("Response code: " + conn.getResponseCode());
		BufferedReader rd;
		if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}
		rd.close();
		conn.disconnect();
		System.out.println(sb.toString());
		JSONObject jsonObject = new JSONObject(sb.toString());
		List<TourDetailInfo> detailList = new ArrayList<TourDetailInfo>();
		jsonObject = jsonObject.getJSONObject("response").getJSONObject("body").getJSONObject("items");
		JSONArray jsonArray = jsonObject.getJSONArray("item");
		System.out.println(jsonObject.keys());
		for (int i = 0; i < jsonArray.length(); i++) {
			detailList.add(new TourDetailInfo(jsonArray.getJSONObject(i).getString("title"),
					jsonArray.getJSONObject(i).getString("homepage"), jsonArray.getJSONObject(i).getString("overview"),
					jsonArray.getJSONObject(i).getString("mapx"), jsonArray.getJSONObject(i).getString("mapy"),
					jsonArray.getJSONObject(i).getString("tel"),
					jsonArray.getJSONObject(i).getString("mlevel")
					));

		}
		model.addAttribute("detailList", detailList);

	}
	
	
//	forslider_1
	public void getTourList2(Model model) throws IOException {
		// TODO Auto-generated method stub
		// 클라이언트에서 넘어온 페이지 번호와 페이지 크기를 받아옵니다.
		StringBuilder urlBuilder = new StringBuilder(
				"https://apis.data.go.kr/B551011/KorService1/areaBasedList1"); /* URL */
		urlBuilder.append(
				"?" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("9999", "UTF-8")); /* 조회시작일자 */
		urlBuilder.append(
				"&" + URLEncoder.encode("MobileOS", "UTF-8") + "=" + URLEncoder.encode("ETC", "UTF-8")); /* 조회시작일자 */
		urlBuilder.append(
				"&" + URLEncoder.encode("MobileApp", "UTF-8") + "=" + URLEncoder.encode("raon", "UTF-8")); /* 조회종료일자 */
		urlBuilder.append(
				"&" + URLEncoder.encode("_type", "UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /* xml 또는 json */
		urlBuilder.append(
				"&" + URLEncoder.encode("contentTypeId", "UTF-8") + "=" + URLEncoder.encode("12", "UTF-8")); /* 측정소명 */
		urlBuilder.append(
				"&" + URLEncoder.encode("areaCode", "UTF-8") + "=" + URLEncoder.encode("39", "UTF-8")); /* 측정소명 */
		urlBuilder.append("&" + URLEncoder.encode("serviceKey", "UTF-8")
				+ "=b7k%2B9H2DZnNoOhZSPNTopjx1cG%2F8y74JvA2aFmp4dlvoRTGzmxGL976Dcdg0PTLdbegGkqm466WbLV5PHNOwmw%3D%3D");

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/json");
		System.out.println("Response code: " + conn.getResponseCode());
		BufferedReader rd;
		if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}
		rd.close();
		conn.disconnect();
		System.out.println(sb.toString());
		JSONObject jsonObject = new JSONObject(sb.toString());
		List<TourInfo> tList = new ArrayList<TourInfo>();
		jsonObject = jsonObject.getJSONObject("response").getJSONObject("body").getJSONObject("items");
		JSONArray jsonArray = jsonObject.getJSONArray("item");		
		for (int i = 0; i < jsonArray.length(); i++) {
			tList.add(new TourInfo(jsonArray.getJSONObject(i).getString("title"),
					jsonArray.getJSONObject(i).getString("addr1"), jsonArray.getJSONObject(i).getString("addr2"),
					jsonArray.getJSONObject(i).getString("contentid"), jsonArray.getJSONObject(i).getString("mapx"),
					jsonArray.getJSONObject(i).getString("mapy"), jsonArray.getJSONObject(i).getString("firstimage")

			));

		}
		model.addAttribute("tList2", tList);		
	}
	
	public void getTourDetail2(String[] contentids, Model model) throws IOException {
	    List<TourDetailInfo> detailList2 = new ArrayList<>();

	    for (String contentId : contentids) {
	        // contentId를 사용하여 API 호출을 수행
	        StringBuilder urlBuilder = new StringBuilder(
	                "https://apis.data.go.kr/B551011/KorService1/detailCommon1"); /* URL */
	        urlBuilder.append(
	                "?" + URLEncoder.encode("MobileOS", "UTF-8") + "=" + URLEncoder.encode("ETC", "UTF-8"));
	        urlBuilder.append(
	                "&" + URLEncoder.encode("MobileApp", "UTF-8") + "=" + URLEncoder.encode("raon", "UTF-8"));
	        urlBuilder.append(
	                "&" + URLEncoder.encode("_type", "UTF-8") + "=" + URLEncoder.encode("json", "UTF-8"));
	        urlBuilder.append("&" + URLEncoder.encode("contentId", "UTF-8") + "="
	                + URLEncoder.encode(contentId, "UTF-8"));
	        urlBuilder.append(
	                "&" + URLEncoder.encode("defaultYN", "UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8"));
	        urlBuilder.append(
	                "&" + URLEncoder.encode("firstImageYN", "UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8"));
	        urlBuilder.append(
	                "&" + URLEncoder.encode("areacodeYN", "UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8"));
	        urlBuilder.append(
	                "&" + URLEncoder.encode("mapinfoYN", "UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8"));
	        urlBuilder.append(
	                "&" + URLEncoder.encode("overviewYN", "UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8"));
	        urlBuilder.append("&" + URLEncoder.encode("serviceKey", "UTF-8")
	                + "=b7k%2B9H2DZnNoOhZSPNTopjx1cG%2F8y74JvA2aFmp4dlvoRTGzmxGL976Dcdg0PTLdbegGkqm466WbLV5PHNOwmw%3D%3D");

	        URL url = new URL(urlBuilder.toString());
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setRequestProperty("Content-type", "application/json");

	        // API 응답 받기
	        StringBuilder sb = new StringBuilder();
	        try (BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream()))) {
	            String line;
	            while ((line = rd.readLine()) != null) {
	                sb.append(line);
	            }
	        }

	        // 응답 데이터를 파싱하여 TourDetailInfo 객체 생성 후 리스트에 추가
	        JSONObject jsonObject = new JSONObject(sb.toString());
	        jsonObject = jsonObject.getJSONObject("response").getJSONObject("body").getJSONObject("items");
	        JSONArray jsonArray = jsonObject.getJSONArray("item");
	        for (int i = 0; i < jsonArray.length(); i++) {
	            JSONObject item = jsonArray.getJSONObject(i);
	            TourDetailInfo detailInfo = new TourDetailInfo(
	                item.getString("overview")
	            );
	            detailList2.add(detailInfo);
	        }
	    }

	    // model에 detailList 추가
	    model.addAttribute("overviewList", detailList2);
	}
	public void getBusStation(HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {
	    // TODO Auto-generated method stub
	    String mapx = request.getParameter("mapx");
	    String mapy = request.getParameter("mapy");
	    StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1613000/BusSttnInfoInqireService/getCrdntPrxmtSttnList"); /*URL*/
	    urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=KR1eLnI5BrfL8EDf5l8G3OTQakbgTZ0izb4KANg0SWhwqnP1wHHQQRb%2BrbP1N2a5lnEtjR%2BBvLqfZKaKSZELLQ%3D%3D"); /*Service Key*/
	    urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
	    urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("999", "UTF-8")); /*한 페이지 결과 수*/
	    urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*데이터 타입(xml, json)*/
	    urlBuilder.append("&" + URLEncoder.encode("gpsLati","UTF-8") + "=" + URLEncoder.encode(mapy, "UTF-8")); /*WGS84 위도 좌표*/
	    urlBuilder.append("&" + URLEncoder.encode("gpsLong","UTF-8") + "=" + URLEncoder.encode(mapx, "UTF-8")); /*WGS84 경도 좌표*/
	    URL url = new URL(urlBuilder.toString());
	    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	    conn.setRequestMethod("GET");
	    conn.setRequestProperty("Content-type", "application/json");
	    System.out.println("Response code: " + conn.getResponseCode());
	    BufferedReader rd;
	    if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
	        rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	    } else {
	        rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	    }
	    StringBuilder sb = new StringBuilder();
	    String line;
	    while ((line = rd.readLine()) != null) {
	        sb.append(line);
	    }
	    rd.close();
	    conn.disconnect();
	    System.out.println(sb.toString());
	    JSONObject jsonObject = new JSONObject(sb.toString());
	    List<BusStation> BusStationList = new ArrayList<BusStation>();
	    JSONObject responseObj = jsonObject.getJSONObject("response");
	            Object items = responseObj.getJSONObject("body").get("items");
	            if (items instanceof JSONObject) {
	                JSONObject itemsObj = (JSONObject) items;
	                if (itemsObj.has("item")) {
	                    JSONArray jsonArray = itemsObj.getJSONArray("item");
	                    for (int i = 0; i < jsonArray.length(); i++) {
	                        JSONObject stationObj = jsonArray.getJSONObject(i);
	                        String nodenm = stationObj.getString("nodenm");
	                        if (!nodenm.contains("투어")) {
	                            BusStationList.add(new BusStation(stationObj.getInt("citycode"),
	                                    stationObj.getDouble("gpslati"), stationObj.getDouble("gpslong"),
	                                    stationObj.getString("nodeid"), nodenm));
	                        }
	                    }
	                } else {
	                    // "item"이 없는 경우
	                    System.out.println("API 응답에 'item'이 없습니다.");
	                    // "정보없음"을 리스트에 추가
	                    BusStationList.add(new BusStation(-1, -1.0, -1.0, "N/A", "N/A"));
	                }
	            } else {
	                // "items"가 JSONObject가 아닌 경우
	                System.out.println("API 응답에 'items'가 JSONObject가 아닙니다.");
	                // "정보없음"을 리스트에 추가
	                BusStationList.add(new BusStation(-1, -1.0, -1.0, "정보 없음", "정보 없음"));
	            }
	        
	    model.addAttribute("BusStationList", BusStationList);
	}

	
	public void getAllBus(@Param("nodeid") String nodeid, Model model) throws IOException {
	    // TODO Auto-generated method stub
		String nodeids = nodeid;
	    List<Bus> allbus = new ArrayList<Bus>();
	        StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1613000/BusSttnInfoInqireService/getSttnThrghRouteList"); /*URL*/
	        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=KR1eLnI5BrfL8EDf5l8G3OTQakbgTZ0izb4KANg0SWhwqnP1wHHQQRb%2BrbP1N2a5lnEtjR%2BBvLqfZKaKSZELLQ%3D%3D"); /*Service Key*/
	        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
	        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("999", "UTF-8")); /*한 페이지 결과 수*/
	        urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*데이터 타입(xml, json)*/
	        urlBuilder.append("&" + URLEncoder.encode("cityCode","UTF-8") + "=" + URLEncoder.encode("39", "UTF-8")); /*도시코드*/
	        urlBuilder.append("&" + URLEncoder.encode("nodeid","UTF-8") + "=" + URLEncoder.encode(nodeids, "UTF-8")); /*정류소ID*/
	        URL url = new URL(urlBuilder.toString());
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setRequestProperty("Content-type", "application/json");
	        System.out.println("Response code: " + conn.getResponseCode());
	        BufferedReader rd;
	        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
	            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        } else {
	            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	        }
	        StringBuilder sb = new StringBuilder();
	        String line;
	        while ((line = rd.readLine()) != null) {
	            sb.append(line);
	        }
	        rd.close();
	        conn.disconnect();
	        System.out.println(sb.toString());
	        JSONObject jsonObject = new JSONObject(sb.toString());
	        jsonObject = jsonObject.getJSONObject("response").getJSONObject("body").getJSONObject("items");
	        Object item = jsonObject.get("item");
	        if (item instanceof JSONArray) {
	            JSONArray jsonArray = (JSONArray) item;
	            for (int i = 0; i < jsonArray.length(); i++) {
	                JSONObject busObject = jsonArray.getJSONObject(i);
	                allbus.add(new Bus(busObject.getString("endnodenm"),
	                        busObject.getString("routeid"), String.valueOf(busObject.get("routeno")),
	                        busObject.getString("routetp"), busObject.getString("startnodenm")));
	            }
	        } else if (item instanceof JSONObject) {
	            JSONObject busObject = (JSONObject) item;
	            allbus.add(new Bus(busObject.getString("endnodenm"),
	                    busObject.getString("routeid"), String.valueOf(busObject.get("routeno")),
	                    busObject.getString("routetp"), busObject.getString("startnodenm")));
	        }
	    
	    model.addAttribute("allbus", allbus);
	}


	
	public void getBusArrive(Model model) throws IOException {
	    List<BusStation> allbus = (List<BusStation>) model.getAttribute("BusStationList");
	    List<BusArrive> BusArriveList = new ArrayList<BusArrive>();
	    for (BusStation bus : allbus) {
	        String nodeId = bus.getNodeid();
	        StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1613000/ArvlInfoInqireService/getSttnAcctoArvlPrearngeInfoList"); /*URL*/
	        urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "=KR1eLnI5BrfL8EDf5l8G3OTQakbgTZ0izb4KANg0SWhwqnP1wHHQQRb%2BrbP1N2a5lnEtjR%2BBvLqfZKaKSZELLQ%3D%3D"); /*Service Key*/
	        urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
	        urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("999", "UTF-8")); /*한 페이지 결과 수*/
	        urlBuilder.append("&" + URLEncoder.encode("_type", "UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*데이터 타입(xml, json)*/
	        urlBuilder.append("&" + URLEncoder.encode("cityCode", "UTF-8") + "=" + URLEncoder.encode("39", "UTF-8")); /*도시코드 [상세기능3 도시코드 목록 조회]에서 조회 가능*/
	        urlBuilder.append("&" + URLEncoder.encode("nodeId", "UTF-8") + "=" + URLEncoder.encode(nodeId, "UTF-8")); /*정류소ID [국토교통부(TAGO)_버스정류소정보]에서 조회가능*/
	        URL url = new URL(urlBuilder.toString());
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setRequestProperty("Content-type", "application/json");
	        System.out.println("Response code: " + conn.getResponseCode());
	        BufferedReader rd;
	        if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
	            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        } else {
	            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	        }
	        StringBuilder sb = new StringBuilder();
	        String line;
	        while ((line = rd.readLine()) != null) {
	            sb.append(line);
	        }
	        rd.close();
	        conn.disconnect();
	        System.out.println(sb.toString());
	        JSONObject jsonObject = new JSONObject(sb.toString());
	        JSONObject responseObj = jsonObject.getJSONObject("response");
	        Object items = responseObj.getJSONObject("body").get("items");
	        if (items instanceof JSONObject) {
	            JSONObject itemsObj = (JSONObject) items;
	            if (itemsObj.has("item")) {
	                JSONArray jsonArray;
	                // "item"이 단일 객체인 경우 JSONArray로 변환하여 처리
	                if (itemsObj.get("item") instanceof JSONArray) {
	                    jsonArray = itemsObj.getJSONArray("item");
	                } else {
	                    jsonArray = new JSONArray().put(itemsObj.getJSONObject("item"));
	                }
	                for (int i = 0; i < jsonArray.length(); i++) {
	                    BusArriveList.add(new BusArrive(jsonArray.getJSONObject(i).getInt("arrprevstationcnt"),
	                            jsonArray.getJSONObject(i).getInt("arrtime"), jsonArray.getJSONObject(i).getString("nodeid"),
	                            jsonArray.getJSONObject(i).getString("nodenm"), jsonArray.getJSONObject(i).getString("routeid"),
	                            jsonArray.getJSONObject(i).getInt("routeno"), jsonArray.getJSONObject(i).getString("routetp"),
	                            jsonArray.getJSONObject(i).getString("vehicletp")
	                    ));
	                }
	            } else {
	                // "item"이 없는 경우
	                System.out.println("API 응답에 'item'이 없습니다.");
	                // "정보없음"을 리스트에 추가
	                BusArriveList.add(new BusArrive(-1, -1, "정보 없음", "정보 없음", "정보 없음", -1, "정보 없음", "정보 없음"));
	            }
	        } else {
	            // "items"가 JSONObject가 아닌 경우
	            System.out.println("API 응답에 'items'가 JSONObject가 아닙니다.");
	            // "정보없음"을 리스트에 추가
	            BusArriveList.add(new BusArrive(-1, -1, "정보 없음", "정보 없음", "정보 없음", -1, "정보 없음", "정보 없음"));
	        }
	    }
	    model.addAttribute("BusArriveList", BusArriveList);
	}

}
