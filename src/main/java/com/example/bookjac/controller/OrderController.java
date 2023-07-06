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
import java.util.Map;

@Controller
@RequestMapping("order")
public class OrderController {

    @Autowired
    OrderService service;

    @GetMapping("process")
    public String orderProcess(Model model,
                               @RequestParam(value="page", defaultValue = "1") Integer page){
        Map<String, Object> result = service.listOrder(page);
        model.addAllAttributes(result);

        return "order/process";
    }

}
