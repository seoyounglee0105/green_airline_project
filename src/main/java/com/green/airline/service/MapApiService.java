package com.green.airline.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.airline.repository.interfaces.AirportRepository;
import com.green.airline.repository.model.Airport;

@Service
public class MapApiService {

	@Autowired
	private AirportRepository airportRepository;

	public void mapApiSerch(Airport airport) {

		System.out.println("mapAPI post service 전");
		airportRepository.selectByLikeName(airport.getName());
		System.out.println("mapAPI post service 후");

	}

}
