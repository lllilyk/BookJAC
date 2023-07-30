package com.example.bookjac.mapper;

import com.example.bookjac.domain.Book;
import com.example.bookjac.domain.Cart;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.time.LocalDate;
import java.util.List;

@Mapper
public interface InventoryMapper {
    @Select("""
                SELECT * FROM OrderCart oc LEFT JOIN Book b ON oc.title = b.title
                ORDER BY inserted DESC
            """)
    List<Cart> selectAllOrder();

    @Update("""
            UPDATE OrderCart SET inbounded = #{inbounded}, inboundedDate = #{parsedDate}
            WHERE bookId = #{bookId}
            """)
    Integer updateInboundedDate(String bookId, boolean inbounded, LocalDate parsedDate);

    @Update("""
            UPDATE OrderCart SET inbounded = #{inbounded}, inboundedDate = null
            WHERE bookId = #{bookId}
            """)
    Integer updateInbounded(String bookId, boolean inbounded);

    @Select("""
            SELECT * FROM OrderCart WHERE bookId = #{bookId} 
            """)
    Cart selectOrderByBookId(String bookId);

    @Select("""
                SELECT Count(*) FROM OrderCart oc LEFT JOIN Book b ON oc.title = b.title
                ORDER BY inserted DESC
            """)
    Integer selectAllOrderCount();

    @Select("""
            SELECT * FROM Book
            ORDER By id DESC
            """)
    List<Book> selectAll();

    @Insert("""
            INSERT INTO Book (id, title, writer, publisher, outPrice, totalCount, inCount, displayCount)
            VALUES (#{id}, #{title}, #{writer}, #{publisher}, #{outPrice}, #{totalCount}, #{inCount}, #{displayCount})
            """)
    Integer insertInboundedList(List<Book> result);

}
