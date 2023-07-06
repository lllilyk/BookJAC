package com.example.bookjac.mapper;

import com.example.bookjac.domain.BookList;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface BookListMapper {
    @Select("""
            SELECT * FROM Book
            LIMIT #{startIndex}, #{rowPerPage}            
            """)
    List<BookList> selectAll(Integer startIndex, Integer rowPerPage);

    @Select("""
            SELECT COUNT(*) FROM Book
            """)
    Integer countAll();
}
