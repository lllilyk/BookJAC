package com.example.bookjac.service;

import com.example.bookjac.domain.BookResult;
import com.example.bookjac.domain.Cart;
import com.example.bookjac.mapper.CartMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CartService implements CartServiceI{

    @Autowired
    private CartMapper cartMapper;

    @Override
    public int addCart(Cart cart) {
        Cart checkCart = cartMapper.checkCart(cart);

        /*해당 데이터가 이미 DB에 존재하면 2를 반환*/
        if(checkCart != null){
            return 2;
        }

        /*해당 데이터가 DB에 존재하지 않으면 코드 실행*/
        try {
            return cartMapper.addCart(cart);
        } catch (Exception e){
            /*예외가 발생한 경우에는 0을 반환*/
            return 0;
        }
    }

    @Override
    public List<Cart> getCartList(String memberId, String username) {
        List<Cart> cart = cartMapper.getCart(memberId);

        for(Cart c : cart){
            c.setMemberId(username);
        }
        return cart;
    }

    @Override
    public int modifyCount(Cart cart){
        return cartMapper.modifyCount(cart);
    }

}

