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
            <script>
            SELECT * FROM Settlement
            <if test="startDate != null and endDate != null">
            WHERE inserted &gt;= #{startDate} AND inserted &lt;= #{endDate}
            </if> 
            <if test="selectWay == null or selectWay == 0">
            ORDER BY inserted DESC
            </if>
            <if test="selectWay == 1">
            ORDER BY cash DESC
            </if>            
            <if test="selectWay == 2">
            ORDER BY card DESC
            </if>
            </script>
            """)
    List<Settlement> selectSettlement(String startDate, String endDate, Integer selectWay);

    @Delete("""
            DELETE FROM Settlement WHERE id = #{settlementId}
            """)
    Integer deleteSettlement(Integer settlementId);

    @Select("""
            SELECT * FROM Settlement WHERE id = #{settlementId}
            """)
    Settlement selectSettlementById(Integer settlementId);

    @Update("""
            UPDATE Settlement
            SET cash = #{cash}, card = #{card}, vaultCash = #{vaultCash}
            WHERE id = #{id}
            """)
    Integer modifyDaily(Settlement settlement);
}