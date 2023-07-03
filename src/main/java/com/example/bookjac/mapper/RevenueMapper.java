package com.example.bookjac.mapper;

import com.example.bookjac.domain.Settlement;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface RevenueMapper {
    @Insert("""
            INSERT INTO Settlement
                (cash, card, vaultCash)
            VALUES
                (#{cash}, #{card}, #{vaultCash})
            """)
    Integer insertSettlement(Settlement settlement);

    @Select("""
            SELECT * FROM Settlement ORDER BY inserted DESC
            """)
    List<Settlement> selectSettlement();

    @Delete("""
            DELETE FROM Settlement WHERE id = #{settlementId}
            """)
    Integer deleteSettlement(Integer settlementId);

    @Select("""
            SELECT * FROM Settlement WHERE id = #{settlementId}
            """)
    Settlement selectSettlementById(Integer settlementId);
}
