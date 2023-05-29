package com.green.airline.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MapApiController {

	@GetMapping("/map")
	public String mapApi() {
		return "/board/mapApi";
	}
	
}
