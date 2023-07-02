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

@Controller
@RequestMapping("Revenue")
public class RevenueController {

    @Autowired
    RevenueService revenueService;

    @GetMapping("daily")
    public void daily(Model model) {
        //일일 정산 리스트 포워드
        List<Settlement> settlement = revenueService.selectSettlement();

        model.addAttribute("settlement", settlement);
        model.addAttribute("test", "test");
    }

    @PostMapping("daily")
    public String dailyInput(Settlement settlement) {
        System.out.println(settlement);
        boolean ok = revenueService.insertRevenue(settlement);
        System.out.println(ok);

        return "redirect:/Revenue/daily";
    }

    @GetMapping("monthly")
    public void monthly() {
        // 일일 정산 입력창 forward
    }
}
