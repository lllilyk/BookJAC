package com.example.bookjac.domain;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class Order {
    private Integer id;
    private String title;
    private String writer;
    private String publisher;
    private String categoryId;
    private Integer inPrice;
    private Integer totalCount;
}
