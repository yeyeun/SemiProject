package com.raon.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;

import com.raon.domain.ContentDetail;
import com.raon.domain.Course;
import com.raon.mapper.CourseMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class CourseService {
    @Autowired
    private CourseMapper mapper;
    
    public List<Course> getList(){ //여행코스 전체 리스트 불러오기
        log.info("Service->getList()");
        return mapper.getList();
    }
    
	public Course detail(String contentid) {
		log.info("Service->detail():"+contentid);
		return mapper.detail(contentid);
	}
	
	public void add(@Param("contentid") String contentid, @Param("firstimage") String firstimage, @Param("subcontentid") String subcontentid, @Param("id") String id, @Param("title") String title, @Param("overview") String overview) {
	    mapper.add(contentid, firstimage, subcontentid, id, title, overview);
	}
	
    public Map<String, List<?>> getTitleList(List<String> contentIds) throws IOException{ //여행코스에 해당하는 여행지 이름 불러오기
    	List<String> titleList = new ArrayList<>();
		List<Integer> titleLength = new ArrayList<Integer>();

		// 각 subcontentId 문자열을 반복하여 처리
		for (String subcontentIdListString : contentIds) {
			int itemCount = 0; // 각 API 호출 이후에 추가된 항목의 개수를 저장

			// URL  생성
			StringBuilder urlBuilder = new StringBuilder(
					"https://apis.data.go.kr/B551011/KorService1/detailInfo1"); /* URL */
			urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8")
					+ "=KR1eLnI5BrfL8EDf5l8G3OTQakbgTZ0izb4KANg0SWhwqnP1wHHQQRb%2BrbP1N2a5lnEtjR%2BBvLqfZKaKSZELLQ%3D%3D"); /*
																															 * Service
																															 * Key
																															 */
			urlBuilder.append("&" + URLEncoder.encode("_type", "UTF-8") + "="
					+ URLEncoder.encode("json", "UTF-8")); /* xml 또는 json */
			urlBuilder.append("&" + URLEncoder.encode("MobileOS", "UTF-8") + "=" + URLEncoder.encode("ETC", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("MobileApp", "UTF-8") + "=" + URLEncoder.encode("ETC", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("contentId", "UTF-8") + "="
					+ URLEncoder.encode(subcontentIdListString.trim(), "UTF-8"));
			urlBuilder
					.append("&" + URLEncoder.encode("contentTypeId", "UTF-8") + "=" + URLEncoder.encode("25", "UTF-8"));

			URL url = new URL(urlBuilder.toString());
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-type", "application/json");

			// API 호출 결과 처리
			try (BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream()))) {
				StringBuilder response = new StringBuilder();
				String line;
				while ((line = rd.readLine()) != null) {
					response.append(line);
				}
				System.out.print("!!!!!");
				System.out.println("@@@@@@@@@@@@" + response.toString());

				// JSON 형태의 응답에서 title 값을 추출하여 리스트에 저장
				JSONObject jsonObject = new JSONObject(response.toString());
				jsonObject = jsonObject.getJSONObject("response").getJSONObject("body").optJSONObject("items");
				if (jsonObject != null) { // "items"가 존재하는 경우에만 처리
					JSONArray jsonArray = jsonObject.optJSONArray("item");
					if (jsonArray != null) { // "item"이 존재하는 경우에만 처리
						for (int i = 0; i < jsonArray.length(); i++) {
							titleList.add(jsonArray.getJSONObject(i).getString("subname"));
						}
						itemCount = jsonArray.length();
					} else {
						titleList.add("정보없음"); // "item"이 존재하지 않는 경우 "정보없음" 추가
					}
				} else {
					titleList.add("정보없음"); // "items"가 존재하지 않는 경우 "정보없음" 추가
				}
			} catch (JSONException e) {
				titleList.add("정보없음"); // JSON 파싱 오류가 발생한 경우 "정보없음" 추가
			}
			titleLength.add(itemCount);
			System.out.println(titleLength + "!!!!!!!");

			conn.disconnect();

		}
		Map<String, List<?>> result = new HashMap<>();
		result.put("titleList", titleList);
		result.put("titleLength", titleLength);
		return result;
    }
    
    //여행코스의 subcontentid값을 List로 반환
    public List<String> getSubContents(String contentid) {
    	String sub = mapper.getSubContents(contentid);
    	String sub2 = sub.replace("[","").replace("]", "").replace(",", " ");
    	String arr[] = sub2.split(" ");
    	List<String> subcontentList = new ArrayList<String>();
    	for(int i=0; i<arr.length; i++) {
    		subcontentList.add(arr[i].replace("\"", ""));
    	}
    	
		return subcontentList;	
    }
    	
	//여행코스의 각 여행지 정보 조회
    public void getDetailInfo(List<String> list, Model model) throws IOException{
    	List<ContentDetail> contentdetailList = new ArrayList<ContentDetail>();
		// 리스트 안의 subcontentid 반복문 실행
		for (String subcontent : list) {
			//API 호출
			StringBuilder urlBuilder = new StringBuilder("https://apis.data.go.kr/B551011/KorService1/detailCommon1"); //api URL
			urlBuilder.append("?" + URLEncoder.encode("MobileOS", "UTF-8") + "=" + URLEncoder.encode("ETC", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("MobileApp", "UTF-8") + "=" + URLEncoder.encode("raon", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("contentId", "UTF-8") + "=" + URLEncoder.encode(subcontent.trim(), "UTF-8")); //여행코스 id
			urlBuilder.append("&" + URLEncoder.encode("defaultYN", "UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8")); //기본정보 조회여부
			urlBuilder.append("&" + URLEncoder.encode("firstImageYN", "UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8")); //이미지 조회여부
			urlBuilder.append("&" + URLEncoder.encode("mapinfoYN", "UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8")); //좌표 조회여부
			urlBuilder.append("&" + URLEncoder.encode("overviewYN", "UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8")); //설명 조회여부
			urlBuilder.append("&" + URLEncoder.encode("serviceKey", "UTF-8") + "=mu4MvO6eUoXAtU8dp%2Bdwyt%2B%2F24GYekx10foLVqNhtViQi60IGrp26ujspnFxZvJc5EZ0UhX99Q6eQ%2FdE2pRwiA"); //서비스키
			urlBuilder.append("&" + URLEncoder.encode("_type", "UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); //조회 타입

			URL url = new URL(urlBuilder.toString());
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-type", "application/json");
			
			
			try (BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream()))) {
				StringBuilder response = new StringBuilder();
				String line;
				while ((line = rd.readLine()) != null) {
					response.append(line);
				}
				System.out.println("response.toString========" + response.toString());

				// JSON 형태의 응답에서 title 값을 추출하여 리스트에 저장
				JSONObject jsonObject = new JSONObject(response.toString());
				jsonObject = jsonObject.getJSONObject("response").getJSONObject("body").optJSONObject("items");
				JSONArray jsonArray = jsonObject.optJSONArray("item");
				for (int i = 0; i < jsonArray.length(); i++) {
					contentdetailList.add(
							new ContentDetail(
							jsonArray.getJSONObject(i).getString("title"),jsonArray.getJSONObject(i).getString("contentid"),
							jsonArray.getJSONObject(i).getString("firstimage"),jsonArray.getJSONObject(i).getString("mapx"),
							jsonArray.getJSONObject(i).getString("mapy"),jsonArray.getJSONObject(i).getString("mlevel"),
							jsonArray.getJSONObject(i).getString("overview")
						));
				}
			} catch (JSONException e) {
				System.out.println("여행코스 세부조회 오류");
			}
			
		}
		
		model.addAttribute("contentdetailList",contentdetailList);
    }
    

}
