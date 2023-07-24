package com.example.bookjac.domain;

import lombok.Data;

@Data
public class BookList {
    private String id;
    private String title;
    private String writer;
    private String publisher;
    private Integer categoryId;
    private Integer inPrice;
    private Integer outPrice;
}
