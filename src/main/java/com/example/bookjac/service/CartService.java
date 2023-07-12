package com.example.bookjac.service;

import com.example.bookjac.domain.Cart;
import com.example.bookjac.mapper.CartMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CartService implements CartServiceI{

    @Autowired
    private CartMapper cartMapper;

    @Override
    public int addCart(Cart cart) {
        Cart checkCart = cartMapper.checkCart(cart);

        if(checkCart != null){
            return 2;
        }

        try {
            return cartMapper.addCart(cart);
        } catch (Exception e){
            return 0;
        }
    }

    @Override
    public List<Cart> getCartList(String memberId) {
        List<Cart> cart = cartMapper.getCart(memberId);
        return cart;
    }
}

