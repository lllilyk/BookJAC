package com.example.bookjac.service;

import com.example.bookjac.domain.Cart;
import com.example.bookjac.domain.Order;
import com.example.bookjac.domain.OrderDetails;
import com.example.bookjac.mapper.OrderMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class OrderService {
    @Autowired
    private OrderMapper mapper;

    public Map<String, Object> listOrder(Integer page) {
        Integer booksInPage = 10;

        Integer startIndex = (page -1) * booksInPage;

        Integer countAllBooks = mapper.countAll();

        Integer lastPageNum = (countAllBooks -1) / booksInPage + 1;

        Integer leftPageNum = page -5;
        leftPageNum = Math.max(leftPageNum, 1);

        Integer rightPageNum = page +4;
        rightPageNum = Math.min(rightPageNum, lastPageNum);

        Map<String, Object> pageInfo = new HashMap<>();
        pageInfo.put("leftPageNum", leftPageNum);
        pageInfo.put("rightPageNum", rightPageNum);
        pageInfo.put("currentPageNum", page);
        pageInfo.put("lastPageNum", lastPageNum);

        List<Order> list = mapper.selectAllPage(startIndex, booksInPage);

        return Map.of("pageInfo", pageInfo,
                      "bookList", list);
    }

    public boolean addOrderDetails(OrderDetails od) throws Exception{
        int cnt = mapper.insert(od);
        return cnt == 1;
    }

    public Map<String, Object> orderDetailsList(Integer page, String search) {
        Integer recordsInOrderDetails = 10;

        Integer startIndex = (page -1) * recordsInOrderDetails;

        Integer countAllOrderDetails = mapper.countAllOrderDetails();

        Integer lastPageNum = (countAllOrderDetails -1) / recordsInOrderDetails + 1;

        Integer leftPageNum = page -3;
        leftPageNum = Math.max(leftPageNum, 1);

        Integer rightPageNum = page +2;
        rightPageNum = Math.min(rightPageNum, lastPageNum);

        Map<String, Object> pageInfo = new HashMap<>();
        pageInfo.put("leftPageNum", leftPageNum);
        pageInfo.put("rightPageNum", rightPageNum);
        pageInfo.put("currentPageNum", page);
        pageInfo.put("lastPageNum", lastPageNum);

        List<OrderDetails> list = mapper.selectAllPages(startIndex, recordsInOrderDetails, search);
        return Map.of("pageInfo", pageInfo,
                      "orderDetailsList", list);
    }

    public List<Cart> getOrderCartList(String inserted, String name) {
        List<Cart> cart = mapper.getOrderCart(inserted);

        for(Cart c : cart){
            c.setMemberId(name);
        }
        return cart;
    }

    /* 발주 담당의 이름과 일자로 발주 내역 확인 */
    /*public List<Cart> getOrderCartByNameAndDate(String name, String inserted) {
        List<Cart> cart = mapper.getOrderCartByNameAndDate(name, inserted);

        for(Cart c : cart){
            c.setMemberId(name);
        }
        return cart;
    }*/

    /*public OrderDetails getOrderDetails(Integer id, Authentication auth) {
        OrderDetails od = mapper.selectById(id);
        return od;
    }*/
}
