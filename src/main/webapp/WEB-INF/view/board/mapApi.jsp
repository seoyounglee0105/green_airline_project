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
					<option value="">공항을 선택해주세요</option>
					<option value="대한민국">대한민국</option>
					<option value="동북아시아">동북아시아</option>
					<option value="동남아시아/서남아시아">동남아시아/서남아시아</option>
					<option value="미국">미국</option>
					<option value="유럽">유럽</option>
					<option value="대양주/괌">대양주/괌</option>
					<option value="러시아/몽골/중앙아시아">러시아/몽골/중앙아시아</option>
					<option value="중동/아프리카">중동/아프리카</option>
				</select>
			</div>

			<div class="form-group col-sm-5">
				<label for="airport">공항</label> <select name="selectAirport"
					class="form-control" id="selectAirport">
					<option>전체</option>
				</select>

			</div>
			<button type="button" class="btn--search" id="searchAirport">조회</button>
			<div id="result"></div>
		</form>
	</div>

	<div id="map" style="height: 600px;"></div>
	
</main>
<script>
	$(document).ready(function() {
		$("#selectContinent").change(function() {
			var selectedContinent = $(this).val();

			$.ajax({
				url : "/continent",
				type : "GET",
				data : {
					region : selectedContinent
				},
			}).done(function(res) {
				var target = document.getElementById("selectAirport");
				target.options.length = 0;

				for (var i = 0; i < res.length; i++) {
					var opt = document.createElement("option");
					opt.value = res[i].name;
					opt.innerHTML = res[i].name;
					target.appendChild(opt);
				}
			}).fail(function(error) {
				console.error(error);
			});
		});
	});

	$(document).ready(function() {
		$(".btn--search").on("click", function() {
			// 공항이 선택됬는지 확인
			var selectedAirport = $("#selectAirport").val();
			if (selectedAirport === "") {
				alert("공항을 선택해주세요.");
				return;
			}

			// 공항 이름을 쿼리 파라미터로 담아서 controller로 보내기
			$.ajax({
				url : "/airportPosition",
				type : "GET",
				data : {
					searchName : selectedAirport
				}
			}).done(function(res) {
				var latitude = res.latitude;
				var longitude = res.longitude;
				
				alert(latitude);
				alert(longitude);

				// 구글 맵 API를 이용하여 해당 좌표로 이동
				var map = new google.maps.Map(document.getElementById("map"), {
					center : {
						lat : latitude,
						lng : longitude
					},
					zoom : 18
				});

				// 특정 위치 표시
				var marker = new google.maps.Marker({
					position : {
						lat : latitude,
						lng : longitude
					},
					map : map
				});
			}).fail(function(xhr, status, error) {
				// 요청이 실패했을 때 처리할 코드
				console.error(error);
			});
		});
	});
</script>

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
