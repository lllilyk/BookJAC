package com.example.bookjac.controller;

import com.example.bookjac.domain.Settlement;
import com.example.bookjac.service.RevenueService;
import jakarta.websocket.OnClose;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("Revenue")
public class RevenueController {

    @Autowired
    private RevenueService revenueService;

    @GetMapping("daily")
    public void daily(
            @RequestParam(value = "startDate", required = false) String startDate,
            @RequestParam(value = "endDate", required = false) String endDate,
            @RequestParam(value = "selectWay", required = false) Integer selectWay,
            @RequestParam(value = "month", required = false) String yearMonth,
            Model model) {

        //정산 전체 리스트 조회
        Map<String, Object> info = revenueService.selectSettlement(startDate, endDate, selectWay, yearMonth);

        model.addAllAttributes(info);
    }

    @PostMapping("addDaily")
    public String addDaily(Settlement settlement) {
        //일일 정산 입력 과정
        boolean ok = revenueService.insertRevenue(settlement);

        return "redirect:/Revenue/daily";
    }

    @DeleteMapping("deleteDaily")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteDaily(
            @RequestParam("settlementId") Integer settlementId) {
        //일일 정산 삭제 과정
        Map<String, Object> res = revenueService.deleteRevenue(settlementId);
        System.out.println(res.get("message"));

        return ResponseEntity.ok().body(res);
    }

    @GetMapping("getDailyInfo")
    @ResponseBody
    public Settlement getDailyInfo(@RequestParam("settlementId") Integer settlementId) {

        // 일일 정산 수정 시 기존 정보 조회
        Settlement settlement = revenueService.selectSettlementById(settlementId);
        return settlement;
    }

    @PutMapping("modifyDaily")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> modifyDaily(
            @RequestBody Settlement settlement) {
        // 정산 수정 프로세스 
        Map<String, Object> res = revenueService.modifyDaily(settlement);

        return ResponseEntity.ok().body(res);
    }

    @GetMapping("monthly")
    public void monthly(Model model) {
        // 월별 정산 입력창 forward
        //월별 정보 조회
        Map<String, Object> info =  revenueService.selectSettlementForMonth();

        model.addAllAttributes(info);
    }

    @GetMapping("dailyDetail")
    public void dailyDetail(
            @RequestParam("settlementId") Integer settlementId,
            Model model) {
        //일일 정산 상세 내역 조회
        Map<String, Object> info = revenueService.selectDailyDetailBySettlementId(settlementId);

        model.addAllAttributes(info);
    }

    @GetMapping("dailyDetailSearch")
    @ResponseBody
    public Map<String, Object> dailyDetail(
            @RequestParam("settlementId") Integer settlementId,
            @RequestParam("selectWay") Integer selectWay,
            @RequestParam("payWay") Integer payWay,
            @RequestParam("bookTitle") String bookTitle) {
        //일일 상세 내역 검색 조건별 데이터 조회
        Map<String, Object> result = revenueService.selectDailyDetailBySearch(settlementId, selectWay, payWay, bookTitle);
        return result;
    }

    @GetMapping("monthlySearch")
    @ResponseBody
    public List<Settlement> monthlySearch(
            @RequestParam("selectWay") Integer selectWay,
            @RequestParam("year") String year) {
        //월별 조회
        List<Settlement> result = revenueService.selectMonthlyBySearch(selectWay, year);
        System.out.println(result);
        System.out.println(year);
        return result;

    }
}
