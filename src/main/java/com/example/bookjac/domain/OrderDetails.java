package com.example.bookjac.domain;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class OrderDetails {
    private Integer id;
    private String name;
    private LocalDateTime inserted;
    private Integer totalQuantity;
    private Integer totalPrice;
}
