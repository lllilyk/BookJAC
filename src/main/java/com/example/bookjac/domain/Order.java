package com.example.bookjac.domain;

import lombok.Data;

@Data
public class Order {
    private String id;
    private String title;
    private String writer;
    private String publisher;
    private String categoryId;
    private Integer inPrice;
    private Integer totalCount;
}
