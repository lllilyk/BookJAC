package com.example.bookjac.controller;

import com.example.bookjac.domain.Cart;
import com.example.bookjac.service.InventoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/inventory")
public class InventoryController {

    @Autowired
    private InventoryService service;

    @GetMapping("/inboundSellingList")
    public void inboundSellingList(Model model,
                                   @RequestParam(value = "page", defaultValue = "1") Integer page) {


        //현재 날짜 시간
        LocalDateTime currentDateTime = LocalDateTime.now();
        DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String dateTime = currentDateTime.format(dateTimeFormatter);

        //order 목록
        Map<String, Object> result = service.order(page);

        model.addAttribute("dateTime", dateTime);
        model.addAllAttributes(result);
    }

    @PostMapping("/inbound/{bookId}/{inboundedDate}")
    public ResponseEntity<Map<String, Object>> inbound(@PathVariable("bookId") String bookId,
                                                       @PathVariable("inboundedDate") String inboundedDate) {
        return ResponseEntity.ok().body(service.inbound(bookId, inboundedDate));
    }

    @GetMapping("/inventoryList")
    public void inventoryList(Model model,
                              @RequestParam(value = "page", defaultValue = "1") Integer page) {

        //현재 날짜 시간
        LocalDateTime currentDateTime = LocalDateTime.now();
        DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String dateTime = currentDateTime.format(dateTimeFormatter);

        //총재고 목록
        Map<String, Object> result = service.inventory(page);

        model.addAttribute("dateTime", dateTime);
        model.addAllAttributes(result);
    }

}
