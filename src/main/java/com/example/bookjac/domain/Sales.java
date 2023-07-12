package com.example.bookjac.domain;

import lombok.Data;

import java.util.Date;

@Data
public class Sales {
    private Integer id;
    private Date inserted;
    private Integer bookId;
    private Integer soldCount;
    private Integer pay;
    private Integer settlementId;
    private String title;
    private Integer totalCount;
    private Integer outPrice;
    private Integer inPrice;
    private Integer netIncome;
}
