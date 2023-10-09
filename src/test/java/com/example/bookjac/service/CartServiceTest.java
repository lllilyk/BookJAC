package com.example.bookjac.service;

import com.example.bookjac.domain.Cart;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class CartServiceTest {

    @Autowired
    public CartService service;

    @Test
    public void addCart() {
        //given
        String memberId = "admin2";
        int bookId = 1;
        int count = 2;

        Cart cart = new Cart();
        cart.setMemberId(memberId);
        /*cart.setBookId(bookId);*/
        cart.setBookCount(count);

        //when
        int result = service.addCart(cart);

        //then
        System.out.println("** result : " + result);
    }
}
