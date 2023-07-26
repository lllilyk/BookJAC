package com.example.bookjac.controller;

import com.example.bookjac.domain.Book;
import com.example.bookjac.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


import java.util.Map;

@Controller
@RequestMapping("/")
public class BookController {

    @Autowired
    private BookService service;

    @GetMapping("list")
    public String list(Model model,
                       @RequestParam(value = "page", defaultValue = "1") Integer page,
                       @RequestParam(value = "search", defaultValue = "") String search){
        Map<String, Object> result = service.listBook(page, search);
        model.addAllAttributes(result);
        return "book/list";

    }

    @GetMapping("addEvent")
    public String AddEvent(){

        return "book/addEvent";
    }
    @GetMapping("eventBook")
    public String EventList(Model model,
                            @RequestParam(value = "page", defaultValue = "1") Integer page,
                            @RequestParam(value = "search", defaultValue = "") String search){
        Map<String, Object> result1 = service.listEvent(page, search);
        model.addAllAttributes(result1);
        return "book/eventBook";
    }

    // 판매
    @PostMapping("sell")
    @ResponseBody
    public void bookSell(@RequestBody Book book){
        service.bookSell(book);
    }



}
