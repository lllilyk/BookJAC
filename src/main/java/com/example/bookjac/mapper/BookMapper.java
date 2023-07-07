package com.example.bookjac.mapper;

import com.example.bookjac.domain.Book;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;


import java.util.List;

@Mapper
public interface BookMapper {

    //게시글 목록
    @Select("""
            SELECT
            id, title,writer,publisher,categoryId,inPrice,outPrice,totalCount,inCount,displayCount
            FROM Book
            ORDER By id DESC
            """)
    List<Book> selectAll();
}
