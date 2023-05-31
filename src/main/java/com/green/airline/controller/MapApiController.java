package com.green.airline.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.green.airline.repository.model.Airport;
import com.green.airline.service.MapApiService;

@Controller
public class MapApiController {

	private MapApiService mapApiService;
	
	@GetMapping("/map")
	public String mapApi() {
		
		return "/board/mapApi";
	}
	
	@PostMapping("/map")
	public void mapApi(Airport airport) {
		System.out.println("mapAPI post controller 전");
		System.out.println(airport);
		mapApiService.mapApiSerch(airport);
		System.out.println("mapAPI post controller 후");
		
	}
	
}
