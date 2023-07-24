package com.example.bookjac.domain;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
public class BookResult {
    private String title;
    private String link;
    private String image;
    private String author;
    /*private Integer discount;*/
    private String discount;
    private String publisher;
    /*private Integer isbn;*/
    private String isbn;
    private String description;
    /*private LocalDateTime pubdate;*/
    private String pubdate;

}
