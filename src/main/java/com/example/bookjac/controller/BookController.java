package com.example.bookjac.controller;

import com.example.bookjac.domain.Book;
import com.example.bookjac.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


import java.util.List;
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

    @GetMapping("applyEvent")
    public String ApplyEvent(){
        return "book/applyEvent";
    }




}
