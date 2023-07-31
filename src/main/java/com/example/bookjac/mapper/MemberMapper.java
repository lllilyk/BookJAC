package com.example.bookjac.mapper;

import com.example.bookjac.domain.Member;
import org.apache.ibatis.annotations.*;

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
            FROM Member m LEFT JOIN MemberAuthority ma ON m.id = ma.memberId
            WHERE id = #{id}
            """)
    @ResultMap("memberMap")
    Member selectById(String id);

    @Delete("""
            DELETE FROM Member
            WHERE id = #{id} 
            """)
    Integer deleteById(String id);

    @Update("""
            <script>
            
            UPDATE Member
            SET 
                <if test="password neq null and password neq ''">
                password = #{password},
                </if>
                
                memberNumber = #{memberNumber},
                email = #{email},
                phoneNumber = #{phoneNumber}
            WHERE 
                id = #{id}
                
            </script>
            """)
    Integer update(Member member);

    @Select("""
            SELECT *
            FROM Member
            WHERE email = #{email}
            """)
    Member selectByEmail(String email);

    @Select("""
            SELECT * 
            FROM Member
            WHERE phoneNumber = #{phoneNumber}
            """)
    Member selectByPhoneNumber(String phoneNumber);
}
