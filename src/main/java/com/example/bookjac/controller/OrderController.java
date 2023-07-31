package com.example.bookjac.controller;

import com.example.bookjac.domain.*;
import com.example.bookjac.service.CartService;
import com.example.bookjac.service.NaverBookAPIService;
import com.example.bookjac.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.net.URI;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("order")
public class OrderController {

    private final NaverBookAPIService naverBookAPIService;

    @Autowired
    public OrderController(NaverBookAPIService naverBookAPIService){
        this.naverBookAPIService = naverBookAPIService;
    }
    @Autowired
    OrderService service;

    @GetMapping("process")
    @PreAuthorize("isAuthenticated()")
    public String orderProcess(Model model,
                               @RequestParam(value="page", defaultValue = "1") Integer page,
                               @RequestParam(value="search", defaultValue = "") String search,
                               Authentication auth){

        /* 현재 인증된 사용자의 이름(username) 가져오기 */
        String username = auth.getName();
        Map<String, Object> result = service.listOrder(page, search);
        model.addAllAttributes(result);

        /* 사용자 이름을 order/process.jsp로 전달 */
        model.addAttribute("username", username);

        return "order/process";
    }

    @GetMapping("search")
    public String orderSearch(@RequestParam String text, Model model, Authentication auth){

       /*bookresult를 /order/search.jsp에 출력 -> model 선언*/
       List<BookResult> books = naverBookAPIService.searchBooks(text, auth);
        model.addAttribute("books", books);
        return "order/search";
    }

    @PostMapping("add")
    public String addOrderDetails(OrderDetails od,
                                  RedirectAttributes rttr,
                                  Authentication auth) throws Exception{
        boolean ok = service.addOrderDetails(od);

        if(ok){
            rttr.addFlashAttribute("message", "발주가 성공적으로 처리되었습니다.");
            return "redirect:/order/details";
        } else {
            rttr.addFlashAttribute("message", "발주 처리 중 문제가 발생하였습니다.");
            return "redirect:/order/cart";
        }
    }

    @GetMapping("details")
    @PreAuthorize("isAuthenticated()")
    public String list(Model model,
                       @RequestParam(value="page", defaultValue = "1") Integer page,
                       @RequestParam(value="search", defaultValue = "") String search){

        Map<String, Object> result = service.orderDetailsList(page, search);
        model.addAllAttributes(result);

        return "order/details";
    }

    @GetMapping("/each")
    public String eachOrderDetails(@RequestParam("inserted") String inserted,
                                   Model model){

        List<Cart> orderCartList = service.getOrderCartList(inserted);
        model.addAttribute("orderCartList", orderCartList);
        model.addAttribute("inserted", inserted);
        return "order/each";
    }
}

