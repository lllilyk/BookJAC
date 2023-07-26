package com.example.bookjac.service;

import com.example.bookjac.domain.Cart;

import java.util.List;

public interface CartServiceI {

    /* 발주 품목 추가 */
    public int addCart(Cart cart);

    /* 발주 품목 리스트 */
    public List<Cart> getCartList(String memberId, String username);

    /* 발주 품목 수량 수정 */
    public int modifyCount(Cart cart);
}
