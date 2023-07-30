package com.example.bookjac.service;

import com.example.bookjac.domain.Book;
import com.example.bookjac.domain.Cart;
import com.example.bookjac.mapper.InventoryMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class InventoryService {

    @Autowired
    private InventoryMapper mapper;

    public Map<String, Object> order(Integer page) {

        // 페이지당 행의 개수
        Integer rowPerPage = 20;

        // 페이지당 데이터 개수 구하기
        Integer startIndex = (page - 1) * rowPerPage;

        // 전체레코드수 구하기
        Integer numOfRecords = mapper.selectAllOrderCount();

        // 마지막페이지 번호 구하기
        Integer lastPageNumber = (numOfRecords - 1) / rowPerPage + 1;

        Map<String, Object> pageInfo = new HashMap<>();
        pageInfo.put("currentPageNum", page);
        pageInfo.put("lastPageNum", lastPageNumber);

        List<Cart> result = mapper.selectAllOrder();
        return Map.of("pageInfo", pageInfo, "orderList", result);
    }

    public Map<String, Object> inbound(String bookId, String inboundedDate) {
        Map<String, Object> result = new HashMap<>();
        Cart cartResult = mapper.selectOrderByBookId(bookId);

        LocalDate parsedDate = LocalDate.parse(inboundedDate, DateTimeFormatter.ofPattern("yyyy-MM-dd"));

        if (!cartResult.isInbounded()) {
            Integer updateCnt = mapper.updateInboundedDate(bookId, !cartResult.isInbounded(), parsedDate);
            result.put("inbounded", 1);
        } else {
            Integer updateCnt = mapper.updateInbounded(bookId, !cartResult.isInbounded());
            result.put("inbounded", 0);
        }
        return result;
    }

    public Map<String, Object> inventory(Integer page) {

        // 페이지당 행의 개수
        Integer rowPerPage = 20;

        // 페이지당 데이터 개수 구하기
        Integer startIndex = (page - 1) * rowPerPage;

        // 전체레코드수 구하기
        Integer numOfRecords = mapper.selectAllOrderCount();

        // 마지막페이지 번호 구하기
        Integer lastPageNumber = (numOfRecords - 1) / rowPerPage + 1;

        Map<String, Object> pageInfo = new HashMap<>();
        pageInfo.put("currentPageNum", page);
        pageInfo.put("lastPageNum", lastPageNumber);

        List<Book> result = mapper.selectAll();

        return Map.of("pageInfo", pageInfo, "inventoryList", result);
    }
}
