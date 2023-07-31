package com.example.bookjac.domain;

import lombok.Data;

import java.util.Date;

@Data
public class Book {
    private Integer id;
    private String isbn;
    private String title;
    private String writer;
    private String publisher;
    private String categoryId;
    private Integer inPrice;
    private String outPrice;
    private Integer totalCount;
    private int inCount;
    private int displayCount;
    private String event;
    private String eventStartDate;
    private String eventEndDate;
    private int sellAmount;
    private int refundAmount;
    private String checkEvent;


    // 디스플레이 필요 여부
    private int safeDisplayCount;


}
