package com.example.bookjac.domain;

import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Data
public class Member {
    private String id;
    private String password;
    private String name;
    private LocalDate memberNumber;
    private String email;
    private String phoneNumber;
    private LocalDateTime inserted;
    private List<String> authority;

}
