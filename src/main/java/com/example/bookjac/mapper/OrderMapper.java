package com.example.bookjac.mapper;

import com.example.bookjac.domain.Order;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface OrderMapper {
    @Select("""
            SELECT COUNT(*)
            FROM Book
            """)
    Integer countAll();

    @Select("""
            SELECT id,
                   title,
                   writer,
                   publisher,
                   inPrice,
                   totalCount
            FROM Book
            ORDER BY totalCount
            LIMIT #{startIndex}, #{booksInPage}
            """)
    List<Order> selectAllPage(Integer startIndex, Integer booksInPage);
}
