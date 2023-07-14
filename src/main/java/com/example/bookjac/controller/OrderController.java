package com.example.bookjac.controller;

import com.example.bookjac.domain.Order;
import com.example.bookjac.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("order")
public class OrderController {

    @Autowired
    OrderService service;

    @GetMapping("process")
    @PreAuthorize("isAuthenticated()")
    public String orderProcess(Model model,
                               @RequestParam(value="page", defaultValue = "1") Integer page,
                               Authentication auth){

        /* 현재 인증된 사용자의 이름(username) 가져오기 */
        String username = auth.getName();

        Map<String, Object> result = service.listOrder(page);
        model.addAllAttributes(result);

        /* 사용자 이름을 order/process.jsp로 전달 */
        model.addAttribute("username", username);
        return "order/process";
    }

}
