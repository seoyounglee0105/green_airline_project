<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style>
</style>
<div>
	<main>

		<script>
			$(function() { //화면 로딩후 시작
				
				let List = [
				    "종로2가사거리",
				    "창경궁.서울대학교병원",
				    "명륜3가.성대입구",
				    "종로2가.삼일교",
				    "혜화동로터리.여운형활동터"];
			
				$("#start--search").autocomplete({ //오토 컴플릿트 시작
					source : List, // source는 data.js파일 내부의 List 배열
					focus : function(event, ui) { // 방향키로 자동완성단어 선택 가능하게 만들어줌	
						return false;
					},
					minLength : 1,// 최소 글자수
					delay : 100, //autocomplete 딜레이 시간(ms)
				//disabled: true, //자동완성 기능 끄기
				});
				console.log(List);
			});
		</script>
		<h1>기내 서비스 조회 페이지</h1>
		<div>
			<form action="/inFlightService/inFlightServiceSearch" method="post">
				<div>
					기내 서비스 조회 <input type="text" name="keyword" id="start--search">
					<button type="submit">검색</button>
				</div>
				<div>출/도착지를 입력하여 상세 정보를 확인해 보세요.</div>
				<div>
					<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#start">출발지</button>
					<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#arrival">도착지</button>
				</div>
				<!-- The Modal -->
				<div class="modal fade" id="start">
					<div class="modal-dialog">
						<div class="modal-content">

							<!-- Modal Header -->
							<div class="modal-header">
								<h4 class="modal-title">출발지 검색</h4>
								<button type="button" class="close" data-dismiss="modal">×</button>
							</div>

							<!-- Modal body -->
							<div class="modal-body">
								<input type="text" autocomplete="on" id="start--search" name="" placeholder="도시, 공항">
								<div class="rel--search">
									<ul class="pop--rel--keyword"></ul>
								</div>
							</div>

							<!-- Modal footer -->
							<div class="modal-footer">
								<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
							</div>

						</div>
					</div>
				</div>

				<!-- The Modal -->
				<div class="modal fade" id="arrival">
					<div class="modal-dialog">
						<div class="modal-content">

							<!-- Modal Header -->
							<div class="modal-header">
								<h4 class="modal-title">도착지 검색</h4>
								<button type="button" class="close" data-dismiss="modal">×</button>
							</div>

							<!-- Modal body -->
							<div class="modal-body">
								<input type="text" name="" placeholder="도시, 공항">
							</div>

							<!-- Modal footer -->
							<div class="modal-footer">
								<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
							</div>

						</div>
					</div>
				</div>

			</form>
		</div>
	</main>

</div>
<%@ include file="/WEB-INF/view/layout/footer.jsp"%>