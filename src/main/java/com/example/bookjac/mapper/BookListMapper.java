package com.example.bookjac.mapper;

import com.example.bookjac.domain.BookList;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface BookListMapper {
    @Select("""
            <script>
            <bind name="titlePattern" value="'%' + title + '%'"/>
            <bind name="publisherPattern" value="'%' + publisher + '%'"/>
            SELECT * FROM Book
            <where>
                <if test="title neq ''">
                    title LIKE #{titlePattern}
                </if>
                
                <if test="publisher neq ''">
                AND publisher LIKE #{publisherPattern}
                </if>
                
                <if test='costNum eq "1"'>
                AND inPrice BETWEEN 0 AND 10000
                </if>
                <if test='costNum eq "2"'>
                AND inPrice BETWEEN 10000 AND 50000
                </if>
                <if test='costNum eq "3"'>
                AND inPrice BETWEEN 50000 AND 100000
                </if>
                <if test='costNum eq "4"'>
                AND inPrice >= 100000
                </if>
                
                <if test='sellingPriceNum eq "1"'>
                AND outPrice BETWEEN 0 AND 10000
                </if>
                <if test='sellingPriceNum eq "2"'>
                AND outPrice BETWEEN 10000 AND 50000
                </if>
                <if test='sellingPriceNum eq "3"'>
                AND outPrice BETWEEN 50000 AND 100000
                </if>
                <if test='sellingPriceNum eq "4"'>
                AND outPrice >= 100000
                </if>
                
            </where>
            LIMIT #{startIndex}, #{rowPerPage}            
                        
            </script>
            """)
    List<BookList> selectAll(Integer startIndex, Integer rowPerPage, String title, String publisher, String costNum, String sellingPriceNum);

    @Select("""
            SELECT COUNT(*) FROM Book
            """)
    Integer countAll();

    @Select("""
            <script>
            <bind name="titlePattern" value="'%' + title + '%'"/>
            <bind name="publisherPattern" value="'%' + publisher + '%'"/>
            SELECT COUNT(*) FROM Book
            <where>
                <if test="title neq ''">
                    title LIKE #{titlePattern}
                </if>
                
                <if test="publisher neq ''">
                AND publisher LIKE #{publisherPattern}
                </if>
                
                <if test='costNum eq "1"'>
                AND inPrice BETWEEN 0 AND 10000
                </if>
                <if test='costNum eq "2"'>
                AND inPrice BETWEEN 10000 AND 50000
                </if>
                <if test='costNum eq "3"'>
                AND inPrice BETWEEN 50000 AND 100000
                </if>
                <if test='costNum eq "4"'>
                AND inPrice >= 100000
                </if>
                
                <if test='sellingPriceNum eq "1"'>
                AND outPrice BETWEEN 0 AND 10000
                </if>
                <if test='sellingPriceNum eq "2"'>
                AND outPrice BETWEEN 10000 AND 50000
                </if>
                <if test='sellingPriceNum eq "3"'>
                AND outPrice BETWEEN 50000 AND 100000
                </if>
                <if test='sellingPriceNum eq "4"'>
                AND outPrice >= 100000
                </if>
                
            </where>
            LIMIT #{startIndex}, #{rowPerPage}            
                        
            </script>
            """)
    Integer countAllBySearch(Integer startIndex, Integer rowPerPage, String title, String publisher, String costNum, String sellingPriceNum);
}
