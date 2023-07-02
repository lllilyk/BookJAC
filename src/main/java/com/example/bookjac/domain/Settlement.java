package com.example.bookjac.domain;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class Settlement {

    private Integer id;
    private Integer cash;
    private Integer card;
    private Integer vaultCash;
    private LocalDateTime inserted;
}
