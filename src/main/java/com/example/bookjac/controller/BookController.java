package com.example.bookjac.controller;

import com.example.bookjac.domain.Book;
import com.example.bookjac.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


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

//    @GetMapping("addEvent")
//    public void AddEventForm(){
//    }
//
//    @PostMapping("addEvent")
//    public String addProcess(Book book, RedirectAttributes rttr){
//        boolean ok = service.addEvent(book);
//        if(ok){
//            return"redirect:/eventBook";
//        }else {
//            rttr.addFlashAttribute("book",book);
//            return"redirect:/addEvent";
//        }
//    }

    // 이벤트 등록
    @GetMapping("addEvent/{id}")
    public String addEvent(@PathVariable("id") Integer id, Model model) {
        model.addAttribute("book", service.getBook(id));
        return "book/addEvent";
    }

    @PostMapping("addEvent/{id}")
    public String addEventProcess(Book book, RedirectAttributes rttr){
        boolean ok = service.addEvent(book);

        if(ok){
            rttr.addAttribute("success","success");
            return "redirect:/eventBook";
        }else {
            rttr.addAttribute("fail","fail");
            return "redirect:/addEvent/"+book.getId();
        }
    }


    //수정버튼 눌렀을때 수정폼 보여줌
    @GetMapping("modifyEvent/{id}")
    public String modifyEvent(@PathVariable("id") Integer id, Model model){
        model.addAttribute("book", service.getBook(id));
        return "book/modifyEvent";
    }

    //수정 눌렀을때 수정되게
    @PostMapping("modifyEvent/{id}")
    public String modifyProcess(Book book, RedirectAttributes rttr){
        boolean ok = service.modify(book);

        if(ok){
            rttr.addAttribute("success","success");
            return "redirect:/eventBook";
        }else {
            rttr.addAttribute("fail","fail");
            return "redirect:/modifyEvent/"+book.getId();
        }
    }

    // 이벤트 삭제
    @PostMapping("removeEvent")
    public String remove(Integer id, RedirectAttributes rttr, String title){
        boolean ok = service.remove(id);
        if(ok){
            rttr.addFlashAttribute("message", title + "의 이벤트가 삭제되었습니다.");
            return "redirect:/eventBook";
        } else {
            return "redirect:/id/" +id;
        }
    }

    @GetMapping("/id/{id}")
    public String book(@PathVariable("id") Integer id,Model model){
        Book book = service.getBook(id);
        model.addAttribute("book",book);
        return "book/getEvent";
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

    //환불
    @PostMapping("refund")
    @ResponseBody
    public void bookRefund(@RequestBody Book book){
        service.bookRefund(book);
    }



}
