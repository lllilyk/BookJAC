package com.example.bookjac.service;

import com.example.bookjac.domain.Settlement;
import com.example.bookjac.mapper.RevenueMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RevenueService {

    @Autowired
    RevenueMapper revenueMapper;

    public boolean insertRevenue(Settlement settlement) {
       Integer count = revenueMapper.insertRevenue(settlement);
       System.out.println(count);

       return count == 1;
    }

    public List<Settlement> selectSettlement() {
        List<Settlement> list = revenueMapper.selectSettlement();

        return null;
    }
}
