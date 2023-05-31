<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:choose>
	<c:when test="${\"관리자\".equals(principal.userRole)}">
		<%@ include file="/WEB-INF/view/layout/headerManager.jsp"%>
	</c:when>
	<c:otherwise>
		<%@ include file="/WEB-INF/view/layout/header.jsp"%>
	</c:otherwise>
</c:choose>

<input type="hidden" name="menuName" id="menuName" value="자주 묻는 질문">

<style>
.faqHeader--keyword--wrap {
	width: 1200px;
}

.faq--header {
	margin-bottom: 20px;
	display: flex;
	justify-content: center;
}

.keyword--search--wrap {
	padding: 20px;
	margin-bottom: 50px;
}

.keyword--search--form {
	display: flex;
	justify-content: center;
}

#keyword {
	width: 500px;
	display: flex;
	justify-content: center;
	border: none;
	border-bottom: 2px solid black;
	font-size: 30px;
}

p {
	display: flex;
	flex-direction: column;
	height: 100%;
	margin: 0;
}

.faq--category--wrap {
	display: flex;
	justify-content: space-between;
	margin-right: 30px;
	margin-bottom: 50px;
}

.faq--content--wrap {
	display: none;
}

.faq--toggle {
	display: block;
	background: #eee;
	font-size: 18px;
	margin-bottom: 10px;
	margin-top: 10px;
}

.faq--name--cursor--wrap {
	cursor: pointer;
	font-size: 20px;
	margin-bottom: 10px;
	display: flex;
	flex-direction: row;
}

.faq--faqList--wrap {
	margin-right: 20px;
}

.faq--name--wrap {
	display: flex;
	flex-direction: row;
	justify-content: space-between;
}

.modal-content {
	width: 550px;
	height: 350px;
}

.faq--category--modal--wrap {
	margin-bottom: 15px;
}
</style>

<div>
	<main>
		<div class="faqHeader--keyword--wrap">
			<div class="faq--header">
				<h2>자주묻는질문</h2>
			</div>

			<div class="keyword--search--wrap">
				<form action="/faq/faqSearch" method="get" class="keyword--search--form">
					<input type="text" id="keyword" name="keyword" placeholder="키워드 검색">
					<button class="search--btn btn btn-primary" type="submit">검색</button>
				</form>
			</div>

			<div class="faq--category--content--wrap">
				<div class="faq--category--wrap">
					<c:forEach var="categories" items="${categories}">
						<h4>
							<a href="/faq/faqList?categoryId=${categories.id}">${categories.name}</a>
						</h4>
					</c:forEach>
				</div>

				<div class="faq--faqList--wrap">
					<c:forEach var="faqResponseDtos" items="${faqResponseDtos}">
						<input type="hidden" name="id" value="${faqResponseDtos.id}" id="id" class="${faqResponseDtos.id}">
						<input type="hidden" name="title" value="${faqResponseDtos.title}" id="title">
						<input type="hidden" name="content" value="${faqResponseDtos.content}" id="content">
						<input type="hidden" name="categoryId" value="${faqResponseDtos.categoryId}" id="categoryId">
						<div class="faq--title--content--wrap" id="faq--title--content--wrap${faqResponseDtos.id}">
							<div class="faq--name--wrap">
								<p class="faq--name--cursor--wrap">
									<input type="checkbox" name="id" id="delete--checkbox--id" value="${faqResponseDtos.id}"> [ ${faqResponseDtos.name} ] ${faqResponseDtos.title}
								</p>
								<c:if test="${principal.userRole.equals(\"관리자\")}">
									<button class="btn btn-primary" type="button" data-toggle="modal" data-target="#myModal${faqResponseDtos.id}">수정</button>

									<div class="modal fade" id="myModal${faqResponseDtos.id}">
										<div class="modal-dialog">
											<div class="modal-content">

												<div class="modal-header">
													<input type="text" id="faq--modal--title${faqResponseDtos.id}" value="${faqResponseDtos.title}" style="width: 520px;">
													<button type="button" class="close" data-dismiss="modal">×</button>
												</div>

												<div class="modal-body">
													<div class="faq--category--modal--wrap">
														<select id="faq--modal--category${faqResponseDtos.id}">
															<c:forEach var="categories" items="${categories}">
																<option value="${categories.id}">${categories.name}</option>
															</c:forEach>
														</select>
													</div>
													<div>
														<textarea rows="6" cols="57" style="resize: none;" id="faq--modal--content${faqResponseDtos.id}">${faqResponseDtos.content}</textarea>
													</div>
												</div>

												<div class="modal-footer">
													<button type="button" class="btn btn-primary faq--update--btn" data-dismiss="modal" onclick="updateFaq(${faqResponseDtos.id})">Submit</button>
													<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
												</div>

											</div>
										</div>
									</div>
								</c:if>
							</div>
							<div class="faq--content--wrap">${faqResponseDtos.content}</div>
						</div>
					</c:forEach>
				</div>
			</div>
			<div>
				<c:if test="${principal.userRole.equals(\"관리자\")}">
					<div>
						<button class="btn btn-danger" id="remove--check--btn" name="id" type="button">삭제</button>
						<button class="btn btn-primary" onclick="location.href='/notice/noticeInsert'">글 작성</button>
					</div>
				</c:if>
			</div>
		</div>
	</main>

	<script src="/js/faq.js"></script>
</div>

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>