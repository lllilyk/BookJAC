package com.example.bookjac.security;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;

@Component
public class CustomSecurityChecker {

    public boolean checkBoardWriter(Authentication authentication) {

        return false;
    }
}
