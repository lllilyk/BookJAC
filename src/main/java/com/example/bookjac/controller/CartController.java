package com.example.bookjac.controller;

import com.example.bookjac.domain.Cart;
import com.example.bookjac.service.CartService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class CartController {

    @Autowired
    public CartService cartService;

    @PostMapping("/cart/add")
    @ResponseBody
    // 로그인 검증과정 생략됨 향후 추가필요
    public String addCartPOST(Cart cart){

        // 발주 품목 추가
        int result = cartService.addCart(cart);

        return result + "";
    }

}



