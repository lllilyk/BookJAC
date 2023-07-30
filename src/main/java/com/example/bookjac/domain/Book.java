package com.example.bookjac.domain;

import lombok.Data;

import java.util.Date;

@Data
public class Book {
    private String id;
    private String title;
    private String writer;
    private String publisher;
    private String categoryId;
    private String inPrice;
    private String outPrice;
    private String totalCount;
    private int inCount;
    private int displayCount;
    private String event;
    private String eventStartDate;
    private String eventEndDate;

    // 디스플레이 필요 여부
    private int safeDisplayCount;


}
