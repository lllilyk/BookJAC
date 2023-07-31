package com.example.bookjac.mapper;

import com.example.bookjac.domain.Book;
import com.example.bookjac.domain.Cart;
import org.apache.ibatis.annotations.*;

import java.time.LocalDate;
import java.util.List;

@Mapper
public interface InventoryMapper {
    @Select("""
                SELECT * FROM OrderCart
                ORDER BY inserted DESC
            """)
    List<Cart> selectAllOrder();

    @Update("""
            UPDATE OrderCart SET inbounded = #{inbounded}, inboundedDate = #{parsedDate}
            WHERE cartId = #{cartId}
            """)
    Integer updateInboundedDate(String cartId, boolean inbounded, LocalDate parsedDate);

    @Update("""
            UPDATE OrderCart SET inbounded = #{inbounded}, inboundedDate = null
            WHERE cartId = #{cartId}
            """)
    Integer updateInbounded(String cartId, boolean inbounded);

    @Select("""
            SELECT * FROM OrderCart
            WHERE cartId = #{cartId} 
            """)
    Cart selectOrderByBookId(String cartId);

    @Select("""
                SELECT Count(*) FROM OrderCart oc LEFT JOIN Book b ON oc.bookId = b.isbn
                ORDER BY inserted DESC
            """)
    Integer selectAllOrderCount();

    @Select("""
            SELECT * FROM Book
            ORDER By id DESC
            """)
    List<Book> selectAll();

    @Insert("""
            INSERT INTO Book (isbn, title, writer, publisher, inPrice, totalCount, inCount, displayCount)
            VALUES (#{cart.bookId}, #{cart.title}, #{cart.writer}, #{cart.publisher}, #{cart.inPrice}, #{bookIdWithTotalCount}, #{cart.inCount}, #{cart.displayCount})
            """)
    Integer insertInboundedList(Cart cart, int bookIdWithTotalCount);

//    @Select("""
//                SELECT * FROM OrderCart oc LEFT JOIN Book b ON oc.bookId = b.isbn
//                WHERE oc.cartId = #{cartId}
//                ORDER BY inserted DESC
//            """)
//    Cart selectInboundedOrder(Integer cartId);

    @Delete("""
            DELETE FROM Book
            WHERE isbn IN (SELECT bookId FROM OrderCart WHERE cartId = #{cartId})
            """)
    void deleteBookByCartId(Integer cartId);

    @Select("""
            SELECT * FROM Book
            WHERE isbn = #{isbn}
            """)
    Cart selectOld(String isbn);

    @Update("""
            UPDATE Book SET totalCount = #{bookIdWithTotalCount}
            WHERE isbn = #{bookId}
            """)
    void update(int bookIdWithTotalCount, String bookId);

    @Select("""
                SELECT Count(*) FROM Book
            """)
    Integer selectAllBook();
}
