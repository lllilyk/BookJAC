package com.example.bookjac.service;

import com.example.bookjac.domain.Book;
import com.example.bookjac.mapper.BookMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class BookService {

@Autowired
private BookMapper mapper;
    public Map<String, Object> listBook(Integer page, String search) {
        // 페이지당 행의 수
        Integer rowPerPage = 10;

        // 쿼리 LIMIT 절에 사용할 시작 인덱스
        Integer startIndex = (page - 1) * rowPerPage;

        // 페이지네이션이 필요한 정보
        // 전체 레코드 수
        Integer numOfRecords = mapper.countAll(search);
        // 마지막 페이지 번호
        Integer lastPageNumber = (numOfRecords - 1) / rowPerPage + 1;
        // 페이지네이션 왼쪽번호
        Integer leftPageNum = page - 5;
        // 1보다 작을 수 없음
        leftPageNum = Math.max(leftPageNum, 1);

        // 페이지네이션 오른쪽번호
        Integer rightPageNum = leftPageNum + 9;
        // 마지막페이지보다 클 수 없음
        rightPageNum = Math.min(rightPageNum, lastPageNumber);

        Map<String, Object> pageInfo = new HashMap<>();
        pageInfo.put("rightPageNum", rightPageNum);
        pageInfo.put("leftPageNum", leftPageNum);
        pageInfo.put("currentPageNum", page);
        pageInfo.put("lastPageNum", lastPageNumber);

        //목록
        List<Book> list = mapper.selectAllPaging(startIndex, rowPerPage, search);
        return Map.of("pageInfo", pageInfo,
                "bookList", list);

    }

    public Map<String, Object> listEvent(Integer page, String search) {
        // 페이지당 행의 수
        Integer rowPerPage = 15;

        // 쿼리 LIMIT 절에 사용할 시작 인덱스
        Integer startIndex = (page - 1) * rowPerPage;

        // 페이지네이션이 필요한 정보
        // 전체 레코드 수
        Integer numOfRecords = mapper.countAll(search);
        // 마지막 페이지 번호
        Integer lastPageNumber = (numOfRecords - 1) / rowPerPage + 1;
        // 페이지네이션 왼쪽번호
        Integer leftPageNum = page - 5;
        // 1보다 작을 수 없음
        leftPageNum = Math.max(leftPageNum, 1);

        // 페이지네이션 오른쪽번호
        Integer rightPageNum = leftPageNum + 9;
        // 마지막페이지보다 클 수 없음
        rightPageNum = Math.min(rightPageNum, lastPageNumber);

        Map<String, Object> pageInfo = new HashMap<>();
        pageInfo.put("rightPageNum", rightPageNum);
        pageInfo.put("leftPageNum", leftPageNum);
        pageInfo.put("currentPageNum", page);
        pageInfo.put("lastPageNum", lastPageNumber);

        //목록
        List<Book> list = mapper.selectAllPagingEvent(startIndex, rowPerPage, search);
        return Map.of("pageInfo", pageInfo,
                "eventList", list);
    }

    // 판매
    public void bookSell(Book book) {
        Integer cnt = mapper.bookSellUpdate(book);

    }

    public void bookRefund(Book book) {
        Integer cnt = mapper.bookRefundUpdate(book);
    }

    public Book getBook(Integer id) {
        return mapper.selectById(id);
    }

    // 수정 잘 되었으면 1
    public boolean modify(Book book) {
        int cnt =mapper.update(book);
        return cnt ==1;
    }

    //이벤트 삭제
    public boolean remove(Integer id) {
        int cnt = mapper.deleteById(id);
        return cnt==1;
    }

    public boolean addEvent(Book book) {
        int cnt = mapper.update(book);
        return cnt==1;
    }
}
