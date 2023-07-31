package com.example.bookjac.domain;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class OrderDetails {
    private Integer id;
    private String memberId;
    private String name;
    private String inserted;
    private String totalQuantity;
    private String totalPrice;
}
