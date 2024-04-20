package com.raon.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.annotations.Param;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;

import com.raon.domain.Board;
import com.raon.domain.Cart;
import com.raon.domain.Members;
import com.raon.domain.Mytourpage;
import com.raon.domain.TourDetailInfo;
import com.raon.mapper.MypageMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class MypageService {
	@Setter(onMethod_=@Autowired)
	private MypageMapper mapper;

	public List<Cart> read(String id) {
		log.info("Mypage -> read");
		return mapper.read(id);
	}
	public List<Board> myboard(String writer) {
		log.info("Mypage -> myboard");
		List<Board> myboardlist = mapper.myboard(writer);
		return myboardlist;
	}
	
	 public int insertCart(@Param("id") String id,@Param("contentid") String contentid,@RequestParam("firstimage") String firstimage, @RequestParam("title") String title) {
		 int result = mapper.insertCart(id, contentid, firstimage, title);
		 if(result>=1) {
			 result = 1;
		 }else {
			 result = 0;
		 }
		 return result;
	 }
	 
	 public int isItemInCart(String id, String contentid) {
		 int result = mapper.isItemInCart(id, contentid);
		 if(result>=1) {
			 result = 1;
		 }else {
			 result = 0;
		 }
		 return result;
	 }
	 
	 public int deleteItemInCart(@Param("id") String id,@Param("contentid") String contentid) {
		 int result = mapper.deleteItemInCart(id, contentid);
		 if(result>=1) {
			 result = 1;
		 }else {
			 result = 0;
		 }
		 return result;
	 }
	
	public void getTourDetail(HttpServletRequest request, HttpServletResponse response, Model model)
			throws IOException {
		// TODO Auto-generated method stub
		List<Cart> temp = (List<Cart>) model.getAttribute("mytourList");
		List<Mytourpage> detailList = new ArrayList<Mytourpage>();
		 for (Cart cart : temp) {
		        String contentId = cart.getContentid();
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
						"&" + URLEncoder.encode("mapinfoYN", "UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8")); /* 조회시작일자 */
				urlBuilder.append(
						"&" + URLEncoder.encode("areacodeYN", "UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8")); /* 조회시작일자 */
				urlBuilder.append(
						"&" + URLEncoder.encode("addrinfoYN", "UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8")); /* 조회시작일자 */
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
				jsonObject = jsonObject.getJSONObject("response").getJSONObject("body").getJSONObject("items");
				JSONArray jsonArray = jsonObject.getJSONArray("item");
				System.out.println(jsonObject.keys());
				for (int i = 0; i < jsonArray.length(); i++) {
					detailList.add(new Mytourpage(
							jsonArray.getJSONObject(i).getString("addr1"), jsonArray.getJSONObject(i).getString("overview"),
							jsonArray.getJSONObject(i).getString("mapx"), jsonArray.getJSONObject(i).getString("mapy")
							));

				}
		        
		    }
		log.info("mytour");
		
		
		model.addAttribute("mytourList2", detailList);
	}
}
