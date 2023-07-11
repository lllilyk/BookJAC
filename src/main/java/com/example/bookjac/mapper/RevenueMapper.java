package com.example.bookjac.mapper;

import com.example.bookjac.domain.Cart;
import com.example.bookjac.domain.Sales;
import com.example.bookjac.domain.Settlement;
import org.apache.ibatis.annotations.*;

import java.util.Date;
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
            <if test="(startDate != null and startDate != '') and (endDate != null and endDate != '')">
            WHERE inserted &gt;= #{startDate} AND inserted &lt;= #{endDate}
            </if> 
            <if test="(year != null and year != '') and (month != null and month != '')">
            WHERE MONTH(inserted) = #{month} AND YEAR(inserted) = #{year}
            </if>
            <if test="(month == null or month == '') and (startDate == null or startDate == '')">
            WHERE YEAR(inserted) = YEAR(CURDATE()) AND MONTH(inserted) = MONTH(CURDATE())
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
    List<Settlement> selectSettlement(String startDate, String endDate, Integer selectWay,String year, String month);

    @Select("""
            <script>
            SELECT SUM(cash) sumCash, SUM(card) sumCard, SUM(cash + card) sumIncome
            FROM Settlement
            <if test="(startDate != null and startDate != '') and (endDate != null and endDate != '')">
            WHERE inserted &gt;= #{startDate} AND inserted &lt;= #{endDate}
            </if> 
            <if test="(year != null and year != '') and (month != null and month != '')">
            WHERE MONTH(inserted) = #{month} AND YEAR(inserted) = #{year}
            </if>
            </script>
            """)
    Settlement selectSum(String startDate, String endDate, String year, String month);

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

    @Select("""
            SELECT * FROM Sales JOIN Book ON Sales.bookId = Book.id WHERE settlementId = #{settlementId}
            """)
    List<Sales> selectSalesBySettlementId(Integer settlementId);

    @Select("""
            SELECT SUM(soldCount) sumSoldCount, 
                   SUM(soldCount * inPrice) sumInPrice, 
                   SUM(soldCount * outPrice) sumOutPrice,
                   SUM((soldCount * outPrice) - (soldCount * inPrice)) sumNetIncome
            FROM Sales JOIN Book ON Sales.bookId = Book.id 
            WHERE  settlementId = #{settlementId};
            """)
    Sales selectSumDetailBySettlementId(Integer settlementId);

    @Select("""
            SELECT
                b.title title,
                b.inPrice inPrice,
                b.outPrice outPrice,
                oc.bookCount bookCount,
                b.inPrice * oc.bookCount sumInPrice
            FROM OrderCart oc JOIN Book b ON oc.bookId = b.id 
            WHERE inserted = #{date}
            """)
    List<Cart> selectOrderCartByDate(String date);

    @Select("""
            SELECT
                SUM(oc.bookCount) sumBookCount,
                SUM(b.inPrice * oc.bookCount) sumInPrice
            FROM OrderCart oc JOIN Book b ON oc.bookId = b.id
            WHERE inserted = #{date}
            """)
    Cart selectCartSum(String date);
}
