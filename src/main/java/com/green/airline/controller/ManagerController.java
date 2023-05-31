package com.green.airline.controller;

import java.time.LocalDateTime;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.green.airline.dto.response.MonthlySalesForChartDto;
import com.green.airline.dto.response.RouteCountDto;
import com.green.airline.dto.response.VocCountByTypeDto;
import com.green.airline.dto.response.VocInfoDto;
import com.green.airline.dto.response.CountByYearAndMonthDto;
import com.green.airline.repository.model.Memo;
import com.green.airline.repository.model.User;
import com.green.airline.service.MemoService;
import com.green.airline.service.RouteService;
import com.green.airline.service.TicketPaymentService;
import com.green.airline.service.UserService;
import com.green.airline.service.VocService;
import com.green.airline.utils.Define;

@RequestMapping("/manager")
@Controller
public class ManagerController {
	
	@Autowired
	private TicketPaymentService ticketPaymentService;
	
	@Autowired
	private MemoService memoService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private VocService vocService;
	
	@Autowired
	private RouteService routeService;
	
	@Autowired
	private HttpSession session;
	
	/**
	 * @return 대시보드 (관리자 페이지의 메인)
	 */
	@GetMapping("/dashboard")
	public String dashboardPage(Model model) {
		
		String managerId = ((User) session.getAttribute(Define.PRINCIPAL)).getId();
		
		Integer year = LocalDateTime.now().getYear();
		Integer nowMonth = LocalDateTime.now().getMonthValue();
		
		// 최근 1년간 월간 매출액 (이번 달 제외)
		List<MonthlySalesForChartDto> salesList = ticketPaymentService.readMonthlySales();
		
		// JSON으로 변환
		Gson gson = new Gson();
		JsonArray jsonArray = new JsonArray();
		Iterator<MonthlySalesForChartDto> it = salesList.iterator();
		while (it.hasNext()) {
			MonthlySalesForChartDto dto = it.next();
			JsonObject object = new JsonObject();
			object.addProperty("period", dto.getYear() + "-" + dto.getMonth());
			object.addProperty("sales", dto.getSales());
			jsonArray.add(object);
		}
		String salesData = gson.toJson(jsonArray);
		model.addAttribute("salesData", salesData);
		
		// 해당 월에 작성된 고객의 말씀 유형별 개수
		List<VocCountByTypeDto> vocCountList = vocService.readWriteCountGroupByType(year, nowMonth);
		
		// JSON으로 변환
		JsonArray jsonArray2 = new JsonArray();
		Iterator<VocCountByTypeDto> it2 = vocCountList.iterator();
		while (it2.hasNext()) {
			VocCountByTypeDto dto = it2.next();
			JsonObject object = new JsonObject();
			object.addProperty("type", dto.getType());
			object.addProperty("count", dto.getCount());
			jsonArray2.add(object);
		}
		String vocData = gson.toJson(jsonArray2);
		model.addAttribute("vocData", vocData);
		
		// 운항 노선 이용객 수 순위
		List<RouteCountDto> routeCountList = routeService.readGroupByRouteIdLimitN(10);
		
		// JSON으로 변환
		JsonArray jsonArray3 = new JsonArray();
		Iterator<RouteCountDto> it3 = routeCountList.iterator();
		while (it3.hasNext()) {
			RouteCountDto dto = it3.next();
			JsonObject object = new JsonObject();
			object.addProperty("departure", dto.getDeparture());
			object.addProperty("destination", dto.getDestination());
			object.addProperty("count", dto.getCount());
			jsonArray3.add(object);
		}
		String routeData = gson.toJson(jsonArray3);
		model.addAttribute("routeData", routeData);
		
		// 이번 달 매출액
		MonthlySalesForChartDto nowMonthSales = ticketPaymentService.readSalesByThisMonth(year, nowMonth);
		model.addAttribute("thisMonthSales", nowMonthSales.getSales());
		
		// 저번 달 매출액
		Integer lastMonth = LocalDateTime.now().minusMonths(1).getMonthValue();
		MonthlySalesForChartDto lastMonthSales = null;
		// 만약 저번 달이 12월이라면
		if (lastMonth.intValue() == 12) {
			lastMonthSales = ticketPaymentService.readSalesByThisMonth(year, lastMonth - 1);
		} else {
			lastMonthSales = ticketPaymentService.readSalesByThisMonth(year, lastMonth);
		}
		// 저번 달 대비 매출액 증감 여부 (보류)
		Long salesDiff = nowMonthSales.getSales() - lastMonthSales.getSales();
		model.addAttribute("salesDiff", salesDiff);
		
		// 이번 달 신규 회원 수
		Integer newUserCount = 0;
		CountByYearAndMonthDto newCountDto = userService.readNewUserCount(year, nowMonth);
		// 신규 회원이 존재하지 않으면 null
		if (newCountDto != null) {
			newUserCount = newCountDto.getCount();
		}
		model.addAttribute("newUserCount", newUserCount);
		
		// 이번 달 탈퇴 회원 수
		Integer withdrawUserCount = 0;
		CountByYearAndMonthDto withdrawCountDto = userService.readWithdrawUserCount(year, nowMonth);
		// 탈퇴 회원이 존재하지 않으면 null
		if (withdrawCountDto != null) {
			withdrawUserCount = withdrawCountDto.getCount();
		}
		model.addAttribute("withdrawUserCount", withdrawUserCount);
		
		// 이번 달에 작성된 고객의 말씀 수
		Integer vocCount = 0;
		CountByYearAndMonthDto vocCountDto = vocService.readWriteCount(year, nowMonth);
		// 작성된 고객의 말씀 내역이 존재하지 않으면 null
		if (vocCountDto != null) {
			vocCount = vocCountDto.getCount();
		}
		model.addAttribute("vocCount", vocCount);
		
		// 해당 관리자의 메모 불러오기
		Memo memo = memoService.readByManagerId(managerId);
		model.addAttribute("memo", memo);
		
		// 처리되지 않은 고객의 말씀 리스트 최근순 5개
		List<VocInfoDto> vocList = vocService.readVocListLimit(0, 0, 5);
		model.addAttribute("vocList", vocList);
		// 처리되지 않은 고객의 말씀 리스트 개수
		Integer vocListCount = vocService.readVocList(0).size();
		model.addAttribute("vocListCount", vocListCount);
		
		// 메인 페이지임을 표시 (메뉴 설정 시 필요)
		int isMain = 1;
		model.addAttribute("isMain", isMain);
		
		return "/manager/dashboard";
	}
	
	/**
	 * 메모 갱신
	 */
	@PostMapping("/updateMemo")
	@ResponseBody
	public void updateMemoProc(@RequestBody Memo memo) {
		
		String managerId = ((User) session.getAttribute(Define.PRINCIPAL)).getId();
		memo.setManagerId(managerId);
		memoService.updateMemo(memo);
	}
	
}