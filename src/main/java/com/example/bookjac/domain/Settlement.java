package com.example.bookjac.domain;

import lombok.Data;
import java.util.Date;

@Data
public class Settlement {

    private Integer id;
    private Integer cash;
    private Integer card;
    private Integer vaultCash;
    private Date inserted;
}
