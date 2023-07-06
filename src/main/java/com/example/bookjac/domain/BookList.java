package com.example.bookjac.domain;

import lombok.Data;

@Data
public class BookList {
    private Integer id;
    private String title;
    private String writer;
    private String publisher;
    private Integer categoryId;
    private String inPrice;
    private String outPrice;
}
