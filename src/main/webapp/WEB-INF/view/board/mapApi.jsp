<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script defer src="/js/mapApi.js"></script>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>

<style>
.visual--banner {
	display: inline-block;
	height: 100%;
	width: 100%;
	min-height: 200px;
	padding: 40px 440px 40px 50px;
	background-color: #e6e2df;
	background-repeat: no-repeat;
	background-position: right bottom;
	margin-bottom: 30px;
	background-image: url(../images/tourAirport.png);
	font-size: 20px;
}

.list--searchOpt .btn--search {
	position: relative;
	right: auto;
	top: auto;
	width: 100%;
	height: 40px;
	background: #a70638;
	margin: 0;
	padding: 0;
	border: none;
	cursor: pointer;
	color: white;
	margin-bottom: 30px;
}
</style>

<main>
	<h1>공항 정보</h1>

	<div class="choice--airport">
		<div class="visual--banner">
			취항지 공항의 카운터 위치 및 시설 정보, 공항서비스를<br> 확인하실 수 있습니다.
		</div>
	</div>

	<div class="list--searchOpt">
		<form action="/map" method="post">
			<div class="form-group col-sm-5">
				<label for="selectContinent">지역</label> <select class="form-control"
					name="selectContinent" id="selectContinent"
					onchange="selectContinentChange(this)">
					<option value="airportContinent">공항을 선택해주세요</option>
					<option value="Korea">대한민국</option>
					<option value="NorthEastAsia">동북아시아</option>
					<option value="SouthEaWestAsia">동남아시아/서남아시아</option>
					<option value="USA">미국</option>
					<option value="Europe">유럽</option>
					<option value="OceaniaGuam">대양주/괌</option>
					<option value="CentralAsia">러시아/몽골/중앙아시아</option>
					<option value="MiddleEast">중동/아프리카</option>
				</select>
			</div>

			<div class="form-group col-sm-5">
				<label for="airport">공항</label> <select name="selectAirport"
					class="form-control" id="selectAirport">
					<option>전체</option>
				</select>

			</div>
			<button type="submit" class="btn--search" id="searchAirport">조회</button>
			<div id="result"></div>
		</form>
	</div>

	<div id="map" style="height: 600px;"></div>
</main>

<script type="text/javascript">
	function selectContinentChange(e) {
		var Korea = [ "서울/인천", "서울/김포", "부산/김해", "제주" ];
		var NorthEastAsia = [ "나고야", "도쿄", "오사카", "후쿠오카", "광저우", "상하이", "베이징",
				"홍콩" ];
		var SouthEaWestAsia = [ "다낭", "방콕", "세부", "호찌민", "싱가포르", "델리" ];
		var USA = [ "뉴욕", "로스앤젤레스", "샌프란시스코", "시애틀", "워싱턴", "시카고" ];
		var Europe = [ "런던", "바르셀로나", "로마", "베네치아", "이스탄불", "마드리드", "프라하" ];
		var OceaniaGuam = [ "괌", "브리즈번", "시드니", "오클랜드" ];
		var CentralAsia = [ "모스크바", "블라디보스토크", "하바롭스크", "이르쿠츠크" ];
		var MiddleEast = [ "두바이", "아부다비", "텔아비브" ];

		var target = document.getElementById("selectAirport");

		if (e.value == "Korea") {
			var result = Korea;
		} else if (e.value == "NorthEastAsia") {
			var result = NorthEastAsia;
		} else if (e.value == "SouthEaWestAsia") {
			var result = SouthEaWestAsia;
		} else if (e.value == "USA") {
			var result = USA;
		} else if (e.value == "Europe") {
			var result = Europe;
		} else if (e.value == "OceaniaGuam") {
			var result = OceaniaGuam;
		} else if (e.value == "CentralAsia") {
			var result = CentralAsia;
		} else if (e.value == "MiddleEast") {
			var result = MiddleEast;
		}
		
		target.options.length = 0;

		for (x in result) {
			var opt = document.createElement("option");
			opt.value = result[x];
			opt.innerHTML = result[x];
			target.appendChild(opt);
		}
		
		var selectName = $("#selectAirport option:checked").text();
		console.log(selectName);
	}
</script>

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
