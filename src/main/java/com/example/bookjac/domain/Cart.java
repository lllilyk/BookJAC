package com.example.bookjac.domain;

import lombok.Data;
import lombok.Setter;

import java.time.LocalDate;

@Data
public class Cart {
    private Integer cartId;
    private String memberId;
    private String bookId;
    private Integer bookCount;
    // 합계
    @Setter
    private Integer totalPrice;

    //book
    private String isbn;
    private String title;
    private String writer;
    private String publisher;
    private Integer inPrice;
    private Integer outPrice;
    private boolean inbounded;
    private LocalDate inserted;
    private Integer totalCount;
    private Integer inCount;
    private Integer displayCount;
    private LocalDate inboundedDate;
    private boolean showInbound;

    //sum
    private Integer sumBookCount;
    private Integer sumInPrice;
    private Integer sumOutPrice;

    /*상품당 총 금액*/
    public void CalculateTotalPrice() {
        this.totalPrice = this.inPrice * this.bookCount;
    }

    public Integer getInPrice() {
        if (inPrice == null) {
            return 0;
        }
        return inPrice;
    }
}
