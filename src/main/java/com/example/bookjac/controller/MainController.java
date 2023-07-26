package com.example.bookjac.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class MainController {

    @GetMapping("")
    public String main(Authentication authentication) {
        System.out.println("authentication = " + authentication);
        System.out.println(authentication.getPrincipal());
        System.out.println(authentication.getCredentials());
        return "main";
    }

}
