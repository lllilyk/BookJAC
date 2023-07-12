package com.example.bookjac.domain;

import lombok.Data;

@Data
public class Cart {
    private Integer cartId;
    private String memberId;
    private Integer bookId;
    private Integer bookCount;

    //book
    private String title;
    private String writer;
    private String publisher;
    private String inPrice;
    private Integer outPrice;

    //sum
    private Integer sumBookCount;
    private Integer sumInPrice;
    private Integer sumOutPrice;
}
