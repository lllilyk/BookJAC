package com.example.bookjac.service;

import com.example.bookjac.domain.Order;
import com.example.bookjac.mapper.OrderMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderService {
    @Autowired
    private OrderMapper mapper;

    public List<Order> listOrder() {

        return mapper.selectAll();
    }
}
