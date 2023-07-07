package com.example.bookjac.service;

import com.example.bookjac.domain.Book;
import com.example.bookjac.mapper.BookMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.List;

@Service
public class BookService {

@Autowired
private BookMapper mapper;
    public List<Book> listBook(){
        List<Book> list = mapper.selectAll();
        System.out.println(list);
        return list;

    }

}
