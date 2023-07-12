package com.example.bookjac.mapper;

import com.example.bookjac.domain.Book;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Service;

import java.util.List;

@Mapper
public interface InventoryMapper {
    @Select("""
                        
            """)
    List<Book> selectAll();
}
