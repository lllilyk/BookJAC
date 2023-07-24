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
    private Long sumCash;
    private Long sumCard;
    private Long sumIncome;
    private Long sumOutcome;
    private Long sumNetIncome;
}
