window.initMap = function() {
	const map = new google.maps.Map(document.getElementById("map"), {
		center: { lat: 35.17322, lng: 128.9464591 },
		zoom: 18,
		maxZoom: 19,
		minZoom: 20,
	});

	/*// 특정 위치 표시 위치의 위경도, 생성한 지도 객체 넘기면 생성 됨 
	const airport = [
		{ label: "ICN", name: "인천 국제공항", lat: 37.4692, lng: 126.451 },
		{ label: "GMP", name: "김포 국제공항", lat: 37.5586545, lng: 126.7944739 },
		{ label: "PUS", name: "부산/김해 국제공항", lat: 35.17322, lng: 128.9464591 },
		{ label: "CJU", name: "제주 국제공항", lat: 33.4996213, lng: 126.5311884 },
		{ label: "CAN", name: "광저우 바이윈 국제공항", lat: 23.12911, lng: 113.264385 },
		{ label: "NGO", name: "나고야 주부 국제공항", lat: 35.255, lng: 136.924444 },
		{ label: "NRT", name: "도쿄 국제공항", lat: 35.7647222, lng: 140.386389 },
		{ label: "PVG", name: "상하이 푸둥 국제공항", lat: 31.1443439, lng: 121.808273 },
		{ label: "PEK", name: "베이징 서우두 국제공항", lat: 39.7825, lng: 116.3877778 },
		{ label: "ITM", name: "오사카 간사이 국제공항", lat: 34.6937378, lng: 135.5021651 },
		{ label: "FUK", name: "후쿠오카 공항", lat: 33.5903145, lng: 130.4467091 },
		{ label: "HKG", name: "홍콩 국제공항", lat: 22.3088889, lng: 113.914722 },
		{ label: "DAD", name: "다낭 국제공항", lat: 16.0438889, lng: 108.199444 },
		{ label: "BKK", name: "방콕 수완나품 공항", lat: 13.69, lng: 100.75 },
		{ label: "CEB", name: "막탄 세부 국제공항", lat: 10.3106556, lng: 123.9802214 },
		{ label: "SIN", name: "싱가포르 창이 국제공항", lat: 1.28000, lng: 103.85000 },
		{ label: "SGN", name: "호치민 떤선녓 국제공항", lat: 10.8188889, lng: 106.651944 },
		{ label: "DEL", name: "델리 인디라 간디 국제공항", lat: 28.5663889, lng: 77.1030556 },
		{ label: "JFK", name: "뉴욕 존F.케네디 국제공항", lat: 40.6397222, lng: -73.778889 },
		{ label: "LAX", name: "로스앤젤레스 국제공항", lat: 33.9415889, lng: -118.40853 },
		{ label: "SFO", name: "샌프란시스코 국제공항", lat: 37.7749295, lng: -122.4194155 },
		{ label: "SEA", name: "시애틀 터코마 국제공항", lat: 47.4502499, lng: -122.3088165 },
		{ label: "IAD", name: "워싱턴 덜레스 국제공항", lat: 38.89500, lng: -77.03667 },
		{ label: "ORD", name: "시카고 오헤어 국제공항", lat: 41.9741625, lng: -87.9073214 },
		{ label: "LHR", name: "런던 히드로 국제공항", lat: 51.469604, lng: -0.45356600000002345 },
		{ label: "FCO", name: "로마 레오나르도 다빈치 국제공항", lat: 41.8002778, lng: 12.2388889 },
		{ label: "BCN", name: "바르셀로나 엘프라트 국제공항", lat: 41.2969444, lng: 2.07833333 },
		{ label: "VCE", name: "베네치아 마르코 폴로 국제공항", lat: 45.5044899, lng: 12.3460177 },
		{ label: "IST", name: "이스탄불 아타튀르크 국제공항", lat: 41.0082376, lng: 28.9783589 },
		{ label: "MAD", name: "마드리드 바라하스 국제공항", lat: 40.4936111, lng: -3.5666667 },
		{ label: "PRG", name: "프라하 바츨라프 하벨 국제공항", lat: 50.1008333, lng: 14.26 },
		{ label: "GUM", name: "괌 하갓냐 앤토니오 B. 원 팻 국제공항", lat: 13.51528, lng: 144.83611 },
		{ label: "BNE", name: "브리즈번 국제공항", lat: -27.3942144, lng: 153.1218303 },
		{ label: "SYD", name: "시드니 킹스포드 스미스 국제공항", lat: -33.946111, lng: 151.177222 },
		{ label: "AKL", name: "오클랜드 국제공항", lat: -122.2197428, lng: 37.7125689 },
		{ label: "SVO", name: "모스크바 셰레메티예보 국제공항", lat: 55.9727778, lng: 37.4147222 },
		{ label: "VVO", name: "블라디보스토크 국제공항", lat: 131.8869243, lng: 43.1198091 },
		{ label: "KHV", name: "하바로프스크 국제공항", lat: 48.5280556, lng: 135.188333 },
		{ label: "IKT", name: "이르쿠츠크 국제공항", lat: 52.28697409999999, lng: 104.3050183 },
		{ label: "DXB", name: "두바이 국제공항", lat: 25.2048493, lng: 55.2707828 },
		{ label: "AUH", name: "아부다비 국제공항", lat: 24.441938, lng: 54.6500736 },
		{ label: "TLV", name: "텔아비브 벤구리온 국제공항", lat: 32.0072222, lng: 34.8805556 },
	];*/

	const bounds = new google.maps.LatLngBounds();
	const infowindow = new google.maps.InfoWindow();

	// 조회하기 버튼을 누른 위도 경도 가져와서 마커 생성
	const onClickSearch = () => {
		const latitude = parseFloat(document.getElementById("latitude").value);
		const longitude = parseFloat(document.getElementById("longitude").value);

		const marker = new google.maps.Marker({
			position: { lat: latitude, lng: longitude },
			map,
		});

		bounds.extend(marker.position);

		// 경계 객체 생성 -> 줌 조정하기
		const bounds = new google.maps.LatLngBounds();
		// 마커 클릭시 정보창
		const infowindow = new google.maps.InfoWindow();

		airport.forEach(({ label, name, lat, lng }) => {
			const marker = new google.maps.Marker({
				position: { lat, lng },
				label,
				map,
			});

			// 각 마커의 위치 정보 전달
			bounds.extend(marker.position);

			// 마커 클릭시 정보창
			marker.addListener("click", () => {

				// 클릭 했을 때 지도 중심이 이동
				map.panTo(marker.position);

				infowindow.setContent(`위도: ${latitude}, 경도: ${longitude}`);
				infowindow.open({
					anchor: marker,
					map,
				});
			});
		});

		// 지도 경계 객체 전달
		map.fitBounds(bounds);
	};
};