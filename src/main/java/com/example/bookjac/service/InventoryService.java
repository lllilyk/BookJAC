package com.example.bookjac.service;

import com.example.bookjac.domain.Book;
import com.example.bookjac.mapper.InventoryMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class InventoryService {

    @Autowired
    private InventoryMapper mapper;

    public List<Book> totalInventory() {
        List<Book> result = mapper.selectAll();
        return result;
    }
}
