package com.example.bookjac.service;

import com.example.bookjac.domain.Cart;
import com.example.bookjac.domain.Sales;
import com.example.bookjac.domain.Settlement;
import com.example.bookjac.mapper.RevenueMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class RevenueService {

    @Autowired
    RevenueMapper revenueMapper;

    public boolean insertRevenue(Settlement settlement) {

        //일일 정산 입력
        Integer count = revenueMapper.insertSettlement(settlement);

        return count == 1;
    }

    public Map<String, Object> selectSettlement(String startDate, String endDate, Integer selectWay, String yearMonth) {
        //정산 조회
        Map<String, Object> info = new HashMap<>();

        //파라미터로 받은 yearMonth를 year과 month로 분리
        String year = "";
        String month = "";

        //yearMonth의 값이 있을 경우에만 분리 진행
        if(yearMonth != null && !yearMonth.equals("")) {
            String[] parts = yearMonth.split("-");
            year = parts[0];
            month = parts[1];
        }

        // 정산 리스트 전체 조회
        List<Settlement> list = revenueMapper.selectSettlement(startDate, endDate, selectWay, year, month);

        // 돈통 총액 조회
        Settlement sum = revenueMapper.selectSum(startDate, endDate,year, month);

        //map info에 저장
        info.put("list", list);
        info.put("sum", sum);
        return info;
    }

    public Map<String, Object> deleteRevenue(Integer settlementId) {
        //선택한 일일 정산 삭제
        Integer count = 0;
        Map<String, Object> res = new HashMap<>();

        count = revenueMapper.deleteSettlement(settlementId);

        if (count == 1) {
            res.put("message", "삭제되었습니다.");
        } else {
            res.put("message", "삭제되지 않았습니다.");
        }
        return res;
    }

    public Settlement selectSettlementById(Integer settlementId) {
        // 선택한 일일 정산 조회
        Settlement settlement = revenueMapper.selectSettlementById(settlementId);
        return settlement;
    }

    public Map<String, Object> modifyDaily(Settlement settlement) {
        //선택한 일일 정산 수정
        Map<String, Object> res = new HashMap<>();

        Integer count = revenueMapper.modifyDaily(settlement);

        if (count == 1) {
            res.put("message", "수정되었습니다.");
        } else {
            res.put("message", "수정되지 않았습니다.");
        }
        return res;
    }

    public Map<String, Object> selectDailyDetailBySettlementId(Integer settlementId) {
        Map<String, Object> info = new HashMap<>();

        // 하루 판매 내역 조회(책)
        List<Sales> sales = revenueMapper.selectSalesBySettlementId(settlementId);

        //총액 조회
        Sales sum = revenueMapper.selectSumDetailBySettlementId(settlementId);

        //하루 정산 내역 조회
        Settlement settlement = revenueMapper.selectSettlementById(settlementId);

        //하루 발주 내역 조회
        //날짜 지정
        String date = (1900 + settlement.getInserted().getYear()) + "-" + (settlement.getInserted().getMonth()+1) +  "-" +  settlement.getInserted().getDate();
        //지정된 날짜에 발주된 리스트 조회
        List<Cart> cartList = revenueMapper.selectOrderCartByDate(date);

        //발주 총 금액, 개수 조회
        Cart sumCart = revenueMapper.selectCartSum(date);

        //map에 저장
        info.put("sales", sales);
        info.put("sum", sum);
        info.put("settlement", settlement);
        info.put("cart", cartList);
        info.put("sumCart", sumCart);

        return info;
    }


    public Map<String, Object> selectDailyDetailBySearch(Integer settlementId, Integer selectWay, Integer payWay, String bookTitle) {
        //검색 조건에 따른 조회
        //selectWay : 0=기본값, 1=판매수량, 2=순이익, 3=재고적은순, 4=재고많은순, 5=책제목순
        //payWay : 0=기본값, 1=현금만, 2=카드만
        //bookTitle : 책제목
        Map<String, Object> result = new HashMap<>();

        // 하루 판매 내역 조회(책)
        List<Sales> sales = revenueMapper.selectSalesBySearch(settlementId, selectWay, payWay, bookTitle);

        //총액 조회
        Sales sum = revenueMapper.selectSumDetailBySearch(payWay, settlementId, bookTitle);

        //map에 데이터 저장
        result.put("sales", sales);
        result.put("sum", sum);
        return result;
    }

    public Map<String, Object> selectSettlementForMonth() {
        Map<String, Object> info = new HashMap<>();

        //월별 조회
        List<Settlement> list = revenueMapper.selectSettlementForMonth();
        info.put("list", list);

        return info;
    }
}
