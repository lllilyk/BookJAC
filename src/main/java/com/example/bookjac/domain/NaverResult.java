package com.example.bookjac.domain;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
public class NaverResult {
    private String lastBuildDate;
    private Integer total;
    private Integer start;
    private Integer display;
    private List<BookResult> items;
}
