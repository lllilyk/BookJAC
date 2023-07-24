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

    @Select("""
			<script>
			<bind name="pattern" value="'%' + search + '%'" />
			SELECT COUNT(*) 
			FROM Book
			
			where
			
				   title  LIKE #{pattern}
				OR publisher   LIKE #{pattern}
				OR writer LIKE #{pattern}
			
			
			</script>
			""")
    Integer countAll(String search);

	@Select("""
			<script>
			<bind name="pattern" value="'%' + search + '%'" />
			SELECT
				title,
				writer,
				publisher,
				categoryId
			     
			FROM Book 
			
			where
				
				   title  LIKE #{pattern}
				OR publisher   LIKE #{pattern}
				OR writer LIKE #{pattern}
				
			

			ORDER BY id DESC
			LIMIT #{startIndex}, #{rowPerPage}
			</script>
			""")
	List<Book> selectAllPaging(Integer startIndex, Integer rowPerPage, String search);
}
