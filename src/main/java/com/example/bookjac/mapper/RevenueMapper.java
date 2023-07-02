package com.example.bookjac.mapper;

import com.example.bookjac.domain.Settlement;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface RevenueMapper {
    @Insert("""
            INSERT INTO Settlement
                (cash, card, vaultCash)
            VALUES
                (#{cash}, #{card}, #{vaultCash})
            """)
    Integer insertRevenue(Settlement settlement);

    @Select("""
            SELECT * FROM Settlement
            """)
    List<Settlement> selectSettlement();
}
