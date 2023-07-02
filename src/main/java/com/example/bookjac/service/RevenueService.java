package com.example.bookjac.service;

import com.example.bookjac.domain.Settlement;
import com.example.bookjac.mapper.RevenueMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

@Service
public class RevenueService {

    @Autowired
    RevenueMapper revenueMapper;

    public boolean insertRevenue(Settlement settlement) {
       Integer count = revenueMapper.insertRevenue(settlement);

       return count == 1;
    }

    public Map<String, Object> selectSettlement() {
        Map<String, Object> info = new HashMap<>();

        // 정산 리스트 전체 조회
        List<Settlement> list = revenueMapper.selectSettlement();

        info.put("list", list);

        return info;
    }
}
