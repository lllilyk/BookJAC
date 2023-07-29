package com.example.bookjac.service;

import com.example.bookjac.domain.Cart;
import com.example.bookjac.domain.Order;
import com.example.bookjac.domain.OrderDetails;
import com.example.bookjac.mapper.OrderMapper;
import org.springframework.beans.factory.annotation.Autowired;
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
}
