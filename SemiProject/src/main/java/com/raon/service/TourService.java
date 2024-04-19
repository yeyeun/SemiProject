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

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.raon.domain.TourDetailInfo;
import com.raon.domain.TourInfo;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class TourService {
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

	public void getTourImage(HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {
	    List<String> imgUrls = new ArrayList<String>();
	    String contentId = request.getParameter("contentid");
	    StringBuilder urlBuilder = new StringBuilder("https://apis.data.go.kr/B551011/KorService1/detailImage1");
	    urlBuilder.append("?" + URLEncoder.encode("MobileOS", "UTF-8") + "=" + URLEncoder.encode("ETC", "UTF-8"));
	    urlBuilder.append("&" + URLEncoder.encode("MobileApp", "UTF-8") + "=" + URLEncoder.encode("raon", "UTF-8"));
	    urlBuilder.append("&" + URLEncoder.encode("_type", "UTF-8") + "=" + URLEncoder.encode("json", "UTF-8"));
	    urlBuilder.append("&" + URLEncoder.encode("contentId", "UTF-8") + "=" + URLEncoder.encode(contentId, "UTF-8"));
	    urlBuilder.append("&" + URLEncoder.encode("imageYN", "UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8"));
	    urlBuilder.append("&" + URLEncoder.encode("subImageYN", "UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8"));
	    urlBuilder.append("&" + URLEncoder.encode("serviceKey", "UTF-8") + "=b7k%2B9H2DZnNoOhZSPNTopjx1cG%2F8y74JvA2aFmp4dlvoRTGzmxGL976Dcdg0PTLdbegGkqm466WbLV5PHNOwmw%3D%3D");

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
	    jsonObject = jsonObject.getJSONObject("response").getJSONObject("body").getJSONObject("items");
	    JSONArray jsonArray = jsonObject.getJSONArray("item");
	    System.out.println(jsonObject.keys());
	    for (int i = 0; i < jsonArray.length(); i++) {
	        imgUrls.add(jsonArray.getJSONObject(i).getString("originimgurl"));
	    }
	    // 이미지 URL을 클라이언트로 전송
	    model.addAttribute("imgUrls", imgUrls);
	}
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

}
