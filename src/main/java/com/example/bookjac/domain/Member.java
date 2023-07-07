package com.example.bookjac.domain;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class Member {
    private String id;
    private String password;
    private String name;
    private String memberNumber;
    private String email;
    private String phoneNumber;
    private LocalDateTime inserted;

}
