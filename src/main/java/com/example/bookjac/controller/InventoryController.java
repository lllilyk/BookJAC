package com.example.bookjac.controller;

import com.example.bookjac.domain.Book;
import com.example.bookjac.service.InventoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
@RequestMapping("/inventory")
public class InventoryController {

    @Autowired
    private InventoryService service;

    @GetMapping("/inboundSellingList")
    public void inboundSellingList(Model model) {

        //현재 날짜 시간
        LocalDateTime currentDateTime = LocalDateTime.now();
        DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String dateTime = currentDateTime.format(dateTimeFormatter);

        //총재고 목록
        //List<Book> inventoryList = service.totalInventory();

        model.addAttribute("dateTime", dateTime);


    }
}
