package com.example.bookjac.controller;

import com.example.bookjac.domain.Book;
import com.example.bookjac.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


import java.util.List;

@Controller
@RequestMapping("/")
public class BookController {

    @Autowired
    private BookService service;

    @GetMapping("list")
    public String list(Model model){
        List<Book> list = service.listBook();
        model.addAttribute("bookList", list);
        return "book/list";

    }


}
