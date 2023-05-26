<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<style>

.modal-dialog.modal-fullsize {
	width: 100%;
	height: 100%;
	margin: 0;
	padding: 0;
}

.modal-content.modal-fullsize {
	height: auto;
	min-height: 100%;
	border-radius: 0;
}

.img {
	width: 300px;
	height: 300px;
}

.td--img {
	padding: 5px 20px;
}

.td--board {
	padding: 10px 40px;
}

.board--table {
	flex-wrap: wrap;
}

.modal-header {
	border-bottom: none;
}

.modal-title {
	font-weight: bolder;
}

.btn--write{
	width: 100%;
}

</style>
<main>
	<h1>게시판 화면</h1>
	<div class="container">
		<c:choose>
			<c:when test="${boardList!=null}">
				<%-- 게시글이 있는 경우 --%>
				<div class="board--table d-flex">
					<c:forEach var="board" items="${boardList}">
						<div class="tr--boardList" data-toggle="modal"
							data-target="#modalDetail" id="boardDetail${board.id}"
							style="cursor: pointer;">
							<div class="td--img">
								<img src="<c:url value="${board.thumbnailImage()}"/>" alt=""
									class="img">
							</div>
							<div class="td--board">
								<div>${board.title}</div>
								<div>
									<img src="/images/like/eye.png">${board.viewCount}</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</c:when>
			<c:otherwise>
				<%-- 게시글이 없는 경우 --%>
				<p>게시물이 없습니다.</p>
			</c:otherwise>
		</c:choose>
		<div class="btn--write d-flex flex-row-reverse">
			<button type="button" class="btn btn-primary p-2"
				onclick="location.href='/board/insert'">글 쓰기</button>
		</div>
	</div>
</main>
<%-- Modal --%>
<div class="modal fade" id="modalDetail" data-backdrop="static"
	data-keyboard="false" tabindex="-1" aria-hidden="true">
	<div
		class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h2 class="modal-title">그린에어 여행일지</h2>
				<button type="button" class="close" aria-label="Close"
					data-dismiss="modal">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<%-- 모달 내용 입력 --%>
				<%-- 게시물id 가져와서 경로에 넣어주기 --%>
				<%
				String boardId = request.getParameter("boardId");
				%>
				<div class="board--heart-eye d-flex align-items-center">
					<h2 class="board--title p-2 mr-auto"></h2>
					<div>
						<img src="/images/like/eye.png" id="boardDetail<%=boardId%>">
					</div>
					<div class="board--viewCount p-2"></div>
					<img src="/images/like/like.png"
						class="board--heartCount d-flex jflex-row-reverse"
						id="boardDetail<%=boardId%>"
						style="cursor: pointer; width: 30px; height: 30px;">
					<div class="board--heartCount p-2" id="boardDetail<%=boardId%>"></div>
				</div>
				<div class="board--content" style="text-align: center"></div>
				<div class="board--userId"></div>
				<div class="board--date" id="boardDetail<%=boardId%>"></div>
			</div>
		</div>
	</div>
</div>

<script src="/js/board.js"></script>

<!-- 
=== TODO ===
1. 페이징처리

2-1. 찜 + 조회수 / 게시물 = 높은 숫자 게시물 5개만
상위에 보여주기

2-2 회원만 찜 누를 수 있게하기
// principal이 null이 아닐때만 img태그가 보이게하기
// 비회원은 찜 누르면 로그인창으로

2-3 글 작성 시 썸네일용 이미지 안넣었을 때 예외처리

3 글 작성 날짜 나오게하기

4. 추천순, 조회수 많은순 필터링 기능
-->

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
