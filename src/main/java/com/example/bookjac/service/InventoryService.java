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

    public Map<String, Object> inbound(String cartId, String inboundedDate) {
        Map<String, Object> result = new HashMap<>();
        Cart cartResult = mapper.selectOrderByBookId(cartId);
        System.out.println(cartResult);
        LocalDate parsedDate = LocalDate.parse(inboundedDate, DateTimeFormatter.ofPattern("yyyy-MM-dd"));

        if (cartResult != null) {
            if (!cartResult.isInbounded()) {
                Integer updateCnt = mapper.updateInboundedDate(cartId, !cartResult.isInbounded(), parsedDate);
                result.put("inbounded", 1);
                int total = cartResult.getTotalCount() == null ? 0 : cartResult.getTotalCount();
                int bookIdWithTotalCount = cartResult.getBookCount() + total;
                result.put("total", bookIdWithTotalCount);
                result.put("bookTotal", cartResult.getBookCount());
                mapper.update(bookIdWithTotalCount, cartResult.getBookId());
                Cart c = mapper.selectOld(cartResult.getBookId());
                if (c == null) {
                    mapper.insertInboundedList(cartResult);
                }
            } else {
                Integer updateCnt = mapper.updateInbounded(cartId, !cartResult.isInbounded());
                result.put("inbounded", 0);
                Integer totalC = cartResult.getTotalCount();
                Integer total = totalC == null ? 0 : totalC;
                int bookIdWithTotalCountmi = total - totalC;
                result.put("totalmi", bookIdWithTotalCountmi);
                result.put("bookTotal", cartResult.getBookCount());
                mapper.deleteBookByCartId(cartResult.getCartId());
            }
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


//    public Map<String, Object> deleteInbounded(String cartId) {
//        Map<String, Object> result = new HashMap<>();
//
//        try {
//            // bookId를 이용하여 데이터베이스에서 해당 도서 정보를 삭제합니다.
//            mapper.deleteBookByCartId(cartId);
//
//            result.put("success", true);
//            result.put("message", "도서가 성공적으로 삭제되었습니다.");
//        } catch (Exception e) {
//            result.put("success", false);
//            result.put("message", "도서 삭제에 실패했습니다.");
//        }
//
//        return result;
//    }
}
