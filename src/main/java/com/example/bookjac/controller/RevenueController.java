package com.example.bookjac.controller;

import com.example.bookjac.domain.Settlement;
import com.example.bookjac.service.RevenueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("Revenue")
public class RevenueController {

    @Autowired
    RevenueService revenueService;

    @GetMapping("daily")
    public void daily(Model model) {
        //일일 정산 리스트 포워드
        Map<String, Object> info = revenueService.selectSettlement();

        model.addAllAttributes(info);
    }

    @PostMapping("daily")
    public String dailyInput(Settlement settlement) {
        //일일 정산 입력 과정
        boolean ok = revenueService.insertRevenue(settlement);

        return "redirect:/Revenue/daily";
    }

    @GetMapping("monthly")
    public void monthly() {
        // 일일 정산 입력창 forward
    }
}
