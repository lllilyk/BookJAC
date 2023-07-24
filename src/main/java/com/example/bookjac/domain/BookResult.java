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
    private String discount;
    private String publisher;
    private String isbn;
    private String description;
    private String pubdate;
}
