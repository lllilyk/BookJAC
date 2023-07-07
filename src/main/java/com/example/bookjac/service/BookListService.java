package com.example.bookjac.service;

import com.example.bookjac.domain.BookList;
import com.example.bookjac.mapper.BookListMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class BookListService {

    @Autowired
    private BookListMapper mapper;

    public Map<String, Object> bookList(Integer page, String title, String publisher, String costNum, String sellingPriceNum) {
        // 페이지당 행의 개수
        Integer rowPerPage = 20;

        // 페이지당 데이터 개수 구하기
        Integer startIndex = (page - 1) * rowPerPage;

        // 전체레코드수 구하기
        Integer numOfRecords = mapper.countAll();

        // 마지막페이지 번호 구하기
        Integer lastPageNumber = (numOfRecords - 1) / rowPerPage + 1;

        //검색 후 페이지 레코드수 구하기
        Integer searchNumOfRecords = mapper.countAllBySearch(startIndex, rowPerPage, title, publisher, costNum, sellingPriceNum);
        if (searchNumOfRecords == null) {
            searchNumOfRecords = mapper.countAll();
            ;
        }
        // 검색 후 마지막페이지 번호 구하기
        Integer searchLastPageNumber = (searchNumOfRecords - 1) / rowPerPage + 1;
        searchLastPageNumber = Math.min(searchLastPageNumber, lastPageNumber);

        Map<String, Object> pageInfo = new HashMap<>();
        pageInfo.put("currentPageNum", page);
        pageInfo.put("lastPageNum", lastPageNumber);
        pageInfo.put("searchLastPageNum", searchLastPageNumber);

        // 전체 도서 목록
        List<BookList> list = mapper.selectAll(startIndex, rowPerPage, title, publisher, costNum, sellingPriceNum);
        //System.out.println(list);
        return Map.of("pageInfo", pageInfo, "bookList", list);
    }
}
