package com.example.bookjac.mapper;

import com.example.bookjac.domain.Cart;
import com.example.bookjac.mapper.CartMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class CartMapperTest {

    @Autowired
    public CartMapper mapper;

    /* 발주 품목 추가 */
    @Test
    public void addCart() throws Exception {
        String memberId = "admin";
        int bookId = 1;
        int count = 2;

        Cart cart = new Cart();
        cart.setMemberId(memberId);
        cart.setBookId(bookId);
        cart.setBookCount(count);

        int result = 0;
        result = mapper.addCart(cart);

        System.out.println(result);

    }


    /* 발주 품목 삭제 */
    @Test
    public void deleteCart() {
        int cartId = 1;

        mapper.deleteCart(cartId);

    }

    /* 발주 수량 변경 */
    @Test
    public void modifyCart() {
        int cartId = 3;
        int count = 5;

        Cart cart = new Cart();
        cart.setCartId(cartId);
        cart.setBookCount(count);

        mapper.modifyCount(cart);

    }


    /* 발주 품목 List */
    @Test
    public void getCart() {
        String memberId = "admin";

        List<Cart> list = mapper.getCart(memberId);
        for(Cart cart : list) {
            System.out.println(cart);
        }

    }

    /* 카트 확인 */
    @Test
    public void checkCart() {

        String memberId = "admin";
        int bookId = 3;

        Cart cart = new Cart();
        cart.setMemberId(memberId);
        cart.setBookId(bookId);

        Cart resutlCart = mapper.checkCart(cart);
        System.out.println(resutlCart);

    }
}
