package com.example.bookjac.controller;

import com.example.bookjac.domain.Order;
import com.example.bookjac.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("order")
public class OrderController {

    @Autowired
    OrderService service;

    @GetMapping("process")
    public String orderProcess(Model model){
        List<Order> list = service.listOrder();
        model.addAttribute("bookList", list);
        return "order/process";
    }

}
