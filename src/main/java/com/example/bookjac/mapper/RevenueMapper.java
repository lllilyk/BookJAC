package com.example.bookjac.mapper;

import com.example.bookjac.domain.Cart;
import com.example.bookjac.domain.Sales;
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
            <if test="(startDate != null and startDate != '') and (endDate != null and endDate != '')">
            WHERE inserted &gt;= #{startDate} AND inserted &lt;= #{endDate}
            </if> 
            <if test="(year != null and year != '') and (month != null and month != '')">
            WHERE MONTH(inserted) = #{month} AND YEAR(inserted) = #{year}
            </if>
            <if test="(month == null or month == '') and (startDate == null or startDate == '') and (selectWay != 4)">
            WHERE YEAR(inserted) = YEAR(CURDATE()) AND MONTH(inserted) = MONTH(CURDATE())
            </if>
            <if test="selectWay == 4">
            ORDER BY inserted DESC
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
    List<Settlement> selectSettlement(String startDate, String endDate, Integer selectWay, String year, String month);

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
            SELECT * 
            FROM Sales JOIN Book ON Sales.bookId = Book.id 
            WHERE settlementId = #{settlementId}
            """)
    List<Sales> selectSalesBySettlementId(Integer settlementId);

    @Select("""
            SELECT SUM(soldCount) soldCount, 
                   SUM(soldCount * inPrice) inPrice, 
                   SUM(soldCount * outPrice) outPrice,
                   SUM((soldCount * outPrice) - (soldCount * inPrice)) netIncome
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

    @Select("""
            <script>
            SELECT *,
                (soldCount * outPrice) - (soldCount * inPrice) netIncome
            FROM Sales JOIN Book ON Sales.bookId = Book.id 
            WHERE settlementId = #{settlementId}
            <if test="payWay == 1">
                AND pay = 1
            </if>
            <if test="payWay == 2">
                AND pay = 2
            </if>
            <if test="bookTitle != ''">
            AND title LIKE '%${bookTitle}%'
            </if>
            <if test="selectWay == 1">
                ORDER BY soldCount DESC
            </if>
            <if test="selectWay == 2">
                ORDER BY netIncome DESC
            </if>
            <if test="selectWay == 3">
                ORDER BY totalCount ASC
            </if>
            <if test="selectWay == 4">
                ORDER BY totalCount DESC
            </if>
            <if test="selectWay == 5">
                ORDER BY title ASC
            </if>
            </script>
            """)
    List<Sales> selectSalesBySearch(Integer settlementId, Integer selectWay, Integer payWay, String bookTitle);

    @Select("""
            <script>
            SELECT SUM(soldCount) soldCount, 
                   SUM(soldCount * inPrice) inPrice, 
                   SUM(soldCount * outPrice) outPrice,
                   SUM((soldCount * outPrice) - (soldCount * inPrice)) netIncome
            FROM Sales JOIN Book ON Sales.bookId = Book.id 
            WHERE  settlementId = #{settlementId}
            <if test="bookTitle != ''">
            AND title LIKE '%${bookTitle}%'
            </if>
            <if test="payWay == 1">
                AND pay = 1
            </if>
            <if test="payWay == 2">
                AND pay = 2
            </if>
            </script>
            """)
    Sales selectSumDetailBySearch(Integer payWay, Integer settlementId, String bookTitle);

    @Select("""
            SELECT CONCAT(YEAR(s.inserted), '-', LPAD(MONTH(s.inserted), 2, '0')) AS inserted,
                   SUM(s.card + s.cash) AS sumIncome,
                   SUM(b.inPrice * o.bookCount) AS sumOutcome,
                   SUM((s.card + s.cash) - b.inPrice * o.bookCount) AS sumNetIncome
            FROM Settlement s
                     LEFT JOIN OrderCart o ON MONTH(s.inserted) = MONTH(o.inserted)
                     LEFT JOIN Book b ON o.bookId = b.id
            GROUP BY CONCAT(YEAR(s.inserted), '-', LPAD(MONTH(s.inserted), 2, '0'))
            """)
    List<Settlement> selectSettlementForMonth();

    @Select("""
            SELECT CONCAT(YEAR(s.inserted), '-', LPAD(MONTH(s.inserted), 2, '0')) AS inserted,
                   SUM(s.card + s.cash) AS sumIncome,
                   SUM(b.inPrice * o.bookCount) AS sumOutcome,
                   SUM((s.card + s.cash) - b.inPrice * o.bookCount) AS sumNetIncome
            FROM Settlement s
                     LEFT JOIN OrderCart o ON YEAR(s.inserted) = YEAR(o.inserted) AND MONTH(s.inserted) = MONTH(o.inserted)
                     LEFT JOIN Book b ON o.bookId = b.id
            WHERE YEAR(s.inserted) = #{year}
            GROUP BY CONCAT(YEAR(s.inserted), '-', LPAD(MONTH(s.inserted), 2, '0'))
            """)
    List<Settlement> selectMonthlyBySearch(Integer selectWay, String year);

}
