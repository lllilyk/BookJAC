package com.example.bookjac.controller;

import com.example.bookjac.domain.BookList;
import com.example.bookjac.service.BookListService;
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
public class BookListController {

    @Autowired
    private BookListService service;

    @GetMapping("bookList")
    public void bookList(Model model,
                         @RequestParam(value = "page", defaultValue = "1") Integer page,
                         @RequestParam(value = "title", defaultValue = "") String title,
                         @RequestParam(value = "publisher", defaultValue = "") String publisher,
                         @RequestParam(value = "cost", defaultValue = "") String costNum,
                         @RequestParam(value = "sellingPrice", defaultValue = "") String sellingPriceNum
    ) {
        System.out.println("costNum = " + costNum);
        Map<String, Object> result = service.bookList(page, title, publisher, costNum, sellingPriceNum);

        //model.addAttribute("bookList", result.get("bookList"));
        //model.addAttribute("pageInfo", result.get("pageInfo") );
        model.addAllAttributes(result);
    }

}
