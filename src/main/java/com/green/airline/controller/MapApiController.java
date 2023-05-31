package com.green.airline.controller;

import java.text.DecimalFormat;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.green.airline.repository.model.Airport;
import com.green.airline.service.MapApiService;

@Controller
public class MapApiController {

	@Autowired
	private MapApiService mapApiService;
	
	// 공항 지역, 이름 찾기
	@GetMapping("/continent")
	@ResponseBody
	public List<Airport> continent(String region) {
		List<Airport> list = mapApiService.selectAllName(region);
		
		return list;
	}
	
	// 공항 좌표값 가져오기
	@GetMapping("/airportPosition")
	@ResponseBody
	public List<Airport> airportPosition(String searchName) {
		
		System.out.println(searchName);
		List<Airport> list = mapApiService.airportSerch(searchName);
		System.out.println(list);
		
		DecimalFormat df = new DecimalFormat("#.0000000");
	    String formattedLatitude = df.format(list.get(0).getLatitude());
	    String formattedLongitude = df.format(list.get(0).getLongitude());

	    System.out.println(formattedLatitude);
	    System.out.println(formattedLongitude);
	    
		return list;
	}
	
	@GetMapping("/map")
	public String map() {
		return "/board/mapApi";
	}
	/*
	 * @PostMapping("/map") public void mapApi(Airport airport) {
	 * System.out.println("mapAPI post controller 전"); System.out.println(airport);
	 * mapApiService.mapApiSerch(airport);
	 * System.out.println("mapAPI post controller 후");
	 * 
	 * }
	 */
	
}
