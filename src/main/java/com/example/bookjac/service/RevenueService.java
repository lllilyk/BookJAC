package com.example.bookjac.service;

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

    public Map<String, Object> selectSettlement(String startDate, String endDate, Integer selectWay) {
        //일일 정산 전체 조회
        Map<String, Object> info = new HashMap<>();

        // 정산 리스트 전체 조회
        List<Settlement> list = revenueMapper.selectSettlement(startDate, endDate, selectWay);

        info.put("list", list);

        return info;
    }

    public Map<String, Object> deleteRevenue(Integer settlementId) {
        //선택한 일일 정산 삭제
        Integer count = 0;
        Map<String, Object> res = new HashMap<>();

        count = revenueMapper.deleteSettlement(settlementId);

        if(count == 1) {
            res.put("message", "삭제되었습니다.");
        } else {
            res.put("message", "삭제되지 않았습니다.");
        }
        return res;
    }

    public Settlement selectSettlementById(Integer settlementId) {
        // 선택한 일일 정산 조회
        Settlement settlement = revenueMapper.selectSettlementById(settlementId);
        return  settlement;
    }

    public Map<String, Object> modifyDaily(Settlement settlement) {
        //선택한 일일 정산 수정
        Map<String, Object> res = new HashMap<>();

        Integer count = revenueMapper.modifyDaily(settlement);

        if(count == 1) {
            res.put("message", "수정되었습니다.");
        } else {
            res.put("message", "수정되지 않았습니다.");
        }
        return res;
    }
}