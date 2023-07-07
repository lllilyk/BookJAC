package com.example.bookjac.mapper;

import com.example.bookjac.domain.Member;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Service;

import java.util.List;

@Mapper
public interface MemberMapper {

    @Insert("""
            INSERT INTO Member (id, password, name, memberNumber, email, phoneNumber)
            VALUES (#{id}, #{password}, #{name}, #{memberNumber}, #{email}, #{phoneNumber})
            """)
    int insert(Member member);

    @Select("""
            SELECT *
            FROM Member
            ORDER BY inserted DESC
            """)
    List<Member> selectAll();

    @Select("""
            SELECT * 
            FROM Member 
            WHERE id = #{id}
            """)
    Member selectById(String id);

    @Delete("""
            DELETE FROM Member
            WHERE id = #{id} 
            """)
    Integer deleteById(String id);

    @Update("""
            UPDATE Member
            SET password = #{password},
                memberNumber = #{memberNumber},
                email = #{email},
                phoneNumber = #{phoneNumber}
            WHERE 
                id = #{id}
            """)
    Integer update(Member member);
}
