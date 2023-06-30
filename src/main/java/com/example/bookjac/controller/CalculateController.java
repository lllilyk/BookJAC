package com.example.bookjac.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("Revenue")
public class CalculateController {
    @GetMapping("daily")
    public void daily() {
        System.out.println("working");
    }

    @GetMapping("monthly")
    public void monthly() {
        // 일일 정산 입력창 forward
    }
}
