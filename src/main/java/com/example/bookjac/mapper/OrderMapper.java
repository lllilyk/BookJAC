package com.example.bookjac.mapper;

import com.example.bookjac.domain.Order;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface OrderMapper {
    @Select("""
            SELECT *
            FROM Book
            ORDER BY totalCount
            """
    )
    List<Order> selectAll();
}
